<#
  .SYNOPSIS
  Requests a file hash check.

  .DESCRIPTION
  Request-VirsuTotal.ps1 gets the SHA256 hash of a specified file. It then
  sends the hash through the VirusTotal API. Then fetches the community 
  rating of the hash and outputs it. The greater the rating the less of 
  a risk it is.

  .PARAMETER FileName
  Specifies the path of the file which is to be tested by the API.

  .INPUTS
  None. You can't pipe objects to Request-VirusTotal.ps1.

  .OUTPUTS
  Outputs the reputation and community score of the file.

  .EXAMPLE
  PS> .\Request-VirusTotal.ps1 -FileName .\eicar.txt
#>


#funkcja pobierajaca lokalizacje pliku 
#oblicza SHA 
#przesyla do VirsuTotal
function Request-FileCheck{
    #pobranie wartosci hashu pliku
    param([Parameter(Position=0, mandatory=$true)][String]$FileName)
    $FileHash = (Get-FileHash $FileName).Hash
    #utworzenie zmiennej URI do API 
    $URI = "https://www.virustotal.com/api/v3/files/" + $FileHash
    #tworzenie naglowka
    $headers=@{}
    $headers.Add("accept", "application/json")
    $headers.Add("x-apikey", "")
    #request i zwrot
    $response = Invoke-WebRequest -Uri $URI -Method GET -Headers $headers
    #Write-Host "File status:" $response.StatusDescription
    $response -split {$_ -eq ":" -or $_ -eq ","} | Select-String -Pattern "reputation" -Context 0, 1
}

#call funkcji i pobor lokalizacji pliku
$arg1 = Read-Host "Podaj lokalizacje pliku"
Request-FileCheck -FileName $arg1
