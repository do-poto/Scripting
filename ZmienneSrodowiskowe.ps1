$komputer = $Env:COMPUTERNAME

$data = Get-Date
Write-Host "Obecna data na $komputer to $data"

$sys_ver = [System.Environment]::OSVersion.Version
Write-Host "Wersja systemu na $komputer to $sys_ver"

$user = $Env:USERNAME
Write-Host "Uzytkownik na $komputer to $user"

$ip = (Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4'}).IPAddress[0]
Write-Host "Adres ip na $komputer to $ip"