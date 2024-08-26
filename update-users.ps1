$photo = "./logo.png"
$company = "Adobe"

Connect-MgGraph -Scopes 'User.ReadWrite.All'
$users = Get-MgUser -Filter "endsWith(mail,'adobe.com')" -ConsistencyLevel eventual -CountVariable countVar

foreach($user in $users){
    try {
      $username = $user.DisplayName
      $id = $user.Id
      Set-MgUserPhotoContent -UserId $id -InFile $photo
      Write-Host "$username's photo has been updated!"
      Update-MgUser -UserId $id -CompanyName $company
      Write-Host "$username's company has been updated!"
    }
    catch {
       Write-Host $Error
    }
}