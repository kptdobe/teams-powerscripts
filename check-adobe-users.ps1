$photo = (Get-Item .).FullName + "/adobe-logo.png"
$company = "Adobe"

Connect-MgGraph -Scopes 'User.ReadWrite.All' -NoWelcome

# all adobe user with email ends with @adobe.com but not company set
$users = Get-MgUser -Filter "endsWith(mail,'@adobe.com')" -ConsistencyLevel eventual -CountVariable countVar

# all adobe user with email ends with @adobe.com
# $users = Get-MgUser -Filter "endsWith(mail,'adobe.com')" -ConsistencyLevel eventual -CountVariable countVar

foreach($user in $users){
    try {
      # AD user
      $username = $user.DisplayName
      $mail = $user.Mail
      $id = $user.Id
      $comppany = $user.CompanyName

      if ($company -ne "Adobe") {
        Write-Host "$username's company is not Adobe: $company."
      }

      if ($username + "@adobe.com" -eq $mail) {
        Write-Host "$username's displayName is equal to id. Needs to be manually updated."
      }
      
      
    } catch {
       Write-Host $Error
    }
}