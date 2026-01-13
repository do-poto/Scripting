<#
  .SYNOPSIS
  Requests currency exchange rates from the past 5 days.

  .DESCRIPTION
  Exchange-Currency.ps1 provides the exchange rates of certain two
  specified currencies from the past 5 days. It will output the 
  date followed by currency exchange name and the value for certain days.

  .PARAMETER baseCurrency
  Three letter name of the currency from which the exchange rate
  is calculated.
  
  .PARAMETER targetCurrency
  Three letter name of the currency to which the exchange rate is
  to be calculated.
  
  .INPUTS
  None. You can't pipe objects to ExchangeCurrency.ps1.

  .OUTPUTS
  Outputs the API response along with the date the rate corresponds to.

  .EXAMPLE
  PS> .\ExchangeCurrency.ps1
  Give base currency: EUR
  Gice target currency: PLN
#>
function Request-Rates(){
    #currency params of the function
    param([Parameter (Position=0, mandatory=$true)][String]$baseCurrency, 
    [Parameter (Position=0, mandatory=$true)][String]$targetCurrency)
    
    #create String pattern that will be searched for based on the two input
    #currencies from params
    $exchangePatternString = $baseCurrency + $targetCurrency
    #loop for 5 days prior to todays date
    for([int]$i = -4; $i -le 0; $i++){
        #call date of the iteration
        $currentDate = (Get-Date).AddDays($i).toString("yyyy-MM-dd")
        
        #URI of the API
        $URI = "http://api.currencylayer.com/historical"

        #header of the request
        $headers = @{}
        $headers.add("Content-Type", "application/json")
        
        #body of the request
        $body = @{}
        $body.add("access_key", "[KEY]")
        $body.add("date", $currentDate)
        $body.add("source", $baseCurrency)
        $body.add("currencies", $targetCurrency)
        $body.add("format", "1")

        #call to the API
        $request = Invoke-WebRequest -URI $URI -Headers $headers -Body $body
        #searches for the given parameters in the response of the API
        $response = ($request -split{$_ -eq ":" -or $_ -eq "{" -or $_ -eq "}"} | 
        ForEach-Object {$_.Trim()} |
        Select-String -Pattern $exchangePatternString -Context 0,1)
        
        #print output
        Write-Host $currentDate":`n" $response
        
        #stops funciton for 1s to not overflow API and
        #handle all of the requests
        Start-Sleep -Milliseconds 1000 
    }
}

#ask for parameters of the function
$arg1 = Read-Host "Give base currency"
$arg2 = Read-Host "Give target currency"
#call funciton
Request-Rates -baseCurrency $arg1 -targetCurrency $arg2
