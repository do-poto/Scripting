for($i=0; $i -lt 10; $i++){
   $random = Get-Random -Minimum 0 -Maximum 255
    $ip = "192.168.1." + "$random"
    Write-Host "$ip"
}