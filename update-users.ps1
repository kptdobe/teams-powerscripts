

$photo = (Get-Item .).FullName + "/adobe-logo.png"
# $photo = (Get-Item .).FullName + "/helix-logo.png"
$company = "Adobe"

Connect-MgGraph -Scopes 'User.ReadWrite.All' -NoWelcome
Connect-Entra -Scopes 'User.ReadWrite.All' -NoWelcome

$users = Get-MgUser -Filter "endsWith(mail,'adobe.com')" -ConsistencyLevel eventual -CountVariable countVar
# $users = Get-MgUser -Filter "endsWith(mail,'@adobe.com') and NOT(CompanyName eq 'Adobe')" -ConsistencyLevel eventual -CountVariable countVar
# $users = Get-MgUser -Filter "endsWith(mail,'@AdobeEnterpriseSupportAEM.onmicrosoft.com') and startsWith(DisplayName,'admin')" -ConsistencyLevel eventual -CountVariable countVar

foreach($user in $users){
    try {
      # AD user
      $username = $user.DisplayName
      $mail = $user.Mail
      $id = $user.Id

      Set-EntraUserThumbnailPhoto -UserId $id -FilePath $photo
      if ($res) {
        Write-Host "Updating in Entra: $username's photo has been updated!"
      } else {
        exit;
      }

      Update-MgUser -UserId $id -CompanyName $company
      Write-Host "Updating in Entra: $username's company has been updated!"
    }
    catch {
       Write-Host $Error
    }
}