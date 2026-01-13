<#
  .SYNOPSIS
  Requests view of open ports of an IP addresss to the Shodan API.

  .DESCRIPTION
  Reqquest-Shodan.ps1 requests an API call, to check the open ports
  of the given IP address. Due to the subscription limitations,
  only open test addresses are able to be tested at this time.

  .PARAMETER ipAddress
  Specifies the IP address to be checked

  .INPUTS
  None. You can't pipe objects to Request-Shodan.ps1.

  .OUTPUTS
  States ports that are open on the certain IP address.

  .EXAMPLE
  PS> .\Request-Shodan.ps1
  What ip address to check: 1.1.1.1
#>
function Search-Shodan{
    #parameters declaration
    param([Parameter(Position=0, mandatory=$true)][String]$ipAddress)

    #URI and API key 
    $URI = "https://api.shodan.io/shodan/host/"
    $apiKey = "?key="
    #creation of the full request URI
    $URI = $URI + $ipAddress + $apiKey
    
    #declaration of headers
    $headers = @{}
    $headers.add("Content-Type", "application/json")
    
    #declaration of body
    $body = @{}
    $body.add("minify", $true)

    #API request call
    $request = Invoke-WebRequest -URI $URI -Headers $headers -Body $body
    #conversion from json to readable format
    $response = $request | ConvertFrom-Json
    #prints response
    Write-Host "Open ports for $ipAddress are: "$response.ports
}
#read ip address from the user and pass to the function
$arg1 = Read-Host "What ip address to check"
Search-Shodan -ipAddress $arg1