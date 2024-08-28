

$photo = (Get-Item .).FullName + "/logo.png"
$company = "Adobe"

Connect-MgGraph -Scopes 'User.ReadWrite.All' -NoWelcome
Connect-Entra -Scopes 'User.ReadWrite.All' -NoWelcome

# $users = Get-MgUser -Filter "endsWith(mail,'adobe.com')" -ConsistencyLevel eventual -CountVariable countVar
$users = Get-MgUser -Filter "endsWith(mail,'@adobe.com') and NOT(CompanyName eq 'Adobe')" -ConsistencyLevel eventual -CountVariable countVar

foreach($user in $users){
    try {
      # AD user
      $username = $user.DisplayName
      $mail = $user.Mail
      $id = $user.Id

      Set-MgUserPhotoContent -UserId $id -InFile $photo
      Write-Host "Updating in Entra: $username's photo has been updated!"

      Update-MgUser -UserId $id -CompanyName $company
      Write-Host "Updating in Entra: $username's company has been updated!"

      $teamsUser = Get-EntraUser -Filter "Mail eq '$mail'"

      Set-EntraUserThumbnailPhoto -ObjectId $teamsUser.id -FilePath $photo
      Write-Host "Updating in Teams: $username's photo has been updated!"

      Set-EntraUser -ObjectId $teamsUser.id -CompanyName $company
      Write-Host "Updating in Teams: $username's company has been updated!"
    }
    catch {
       Write-Host $Error
    }
}