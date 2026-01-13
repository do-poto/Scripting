<#
  .SYNOPSIS
  Connects to a server and does a simple script.

  .DESCRIPTION
  Connect-Server.ps1 creates a short session to execute a script
  (pwd, ls) and saves the outputs of the session to a local file.
  
  .INPUTS
  None. You can't pipe objects to Connect-Server.ps1.

  .OUTPUTS
  SessionOutput.txt file in the current working directory.

  .EXAMPLE
  PS> .\Connect-Server.ps1
  Provide full hostname: [username]@[hostname]
#>
function Connect-SessionSSH{
    param([Parameter(Position=0, Mandatory=$true)][String]$hostName)
    
    #script to be executed
    $script = {pwd
    ls}

    #start session and save output to file
    $commandSession  = Invoke-Command -SSHTransport -HostName $hostName -ScriptBlock $script -KeyFilePath C:\Users\cgdpp\.ssh\id_rsa
    $commandSession | Out-File ./SessionOutput.txt  
    Write-Host "Output saved!"
}

#user input of target server
$arg1 = Read-Host "Provide full hostname"
Connect-SessionSSH -hostName $arg1