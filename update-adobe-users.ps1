$photo = (Get-Item .).FullName + "/adobe-logo.png"
$company = "Adobe"

Connect-MgGraph -Scopes 'User.ReadWrite.All' -NoWelcome

# all adobe user with email ends with @adobe.com but not company set
$users = Get-MgUser -Filter "endsWith(mail,'@adobe.com') and NOT(CompanyName eq 'Adobe')" -ConsistencyLevel eventual -CountVariable countVar

# all adobe user with email ends with @adobe.com
# $users = Get-MgUser -Filter "endsWith(mail,'adobe.com')" -ConsistencyLevel eventual -CountVariable countVar

foreach($user in $users){
    try {
      # AD user
      $username = $user.DisplayName
      $mail = $user.Mail
      $id = $user.Id

      $res = Set-MgUserPhotoContent -UserId $id -InFile $photo
      if ($res = $true) {
        Write-Host "Updating user: $username's photo has been updated!"
      } else {
        Write-Host "Updating user: $username's photo has failed! Stopping process. Error: $res"
        exit;
      }

      Update-MgUser -UserId $id -CompanyName $company
      Write-Host "Updating user: $username's company has been updated!"
    } catch {
       Write-Host $Error
    }
}