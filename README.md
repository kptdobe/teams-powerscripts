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
Set-MgUserPhotoContent -UserId xyz -InFile "./logo.png"
```

### Update avatar for all users

See [](./update-users.ps1) script.