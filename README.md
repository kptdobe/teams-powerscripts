# Admin ops

## Powershell 

### Setup

#### Install Powershell

```
brew install powershell/tap/powershell
```

Then to run Powershell:

```
pwsh
```

### Find 'adobe.com' users

```
Connect-MgGraph -Scopes 'User.Read.All'
Get-MgUser -Filter "endsWith(mail,'@adobe.com')" -ConsistencyLevel eventual -CountVariable countVar
```

### Update avatar for one user

```
Connect-MgGraph -Scopes 'User.ReadWrite.All'
Set-MgUserPhotoContent -UserId e8f165b7-a1ee-453b-9c57-823ac717f709 -InFile "/Users/acapt/Downloads/adobe-experience-cloud-logo-rgb.png"
```

### Update avatar for all users

See [](./update-users.ps1) script.