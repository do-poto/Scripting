<#
  .SYNOPSIS
  Connects to a server and checks logs for new SSH connections.

  .DESCRIPTION
  Report-Logs.ps1 connects to a remote server via SSH and check if
  there have been any new logins since it started working. Once
  a new login is detected it will inform the user about it.
  
  .INPUTS
  None. You can't pipe objects to Report-Logs.ps1

  .OUTPUTS
  Outputs "New SSH login detected!" when new SSH login takes place.

  .EXAMPLE
  PS> .\Report-Logs.ps1
  Provide host name: [host name]
  Provide username: [username]
#>
function Report-SSHlogs{
    #parameters of the funciton
    param([Parameter(position = 0, mandatory = $true)][String]$hostName,
    [Parameter(position=1, mandatory=$true)][String]$userName)

    #established session
    $session = New-PSSession -HostName $hostName -UserName $userName
    #fetching original number of logins
    $startLoginNum = Invoke-Command -Session $session -ScriptBlock {journalctl -u ssh | wc -l}
    
    #loops until stopped and searches for changes
    while($true) {
        #check the number of ssh logins
        $currentLoginNum = Invoke-Command -Session $session -ScriptBlock {journalctl -u ssh | wc -l}
        #check if original and current are the same    
        if($currentLoginNum -ne $startLoginNum){
            #current number is now the base number of logins
            $startLoginNum = $currentLoginNum
            #pop out a message for the user
            Write-Host "New SSH login detected!"
        }
        #sleep cycle for 5 seconds to not StackOverflow resources
        Start-Sleep -Seconds 5
    } 
}
#gather connection data
$arg1 = Read-Host "Provide host name"
$arg2 = Read-Host "Provide username"
#invoke funciton
Report-SSHlogs -hostName $arg1 -userName $arg2
