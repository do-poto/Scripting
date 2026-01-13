<#
  .SYNOPSIS
  Monitors a given folder and moves the files to the targeted directory.

  .DESCRIPTION
  Monitor-Folder.ps1 checks if a given directory exists, if it does moves all 
  of the files existing in that directory into the targeted directory. Script performs 
  a check for the existance of the targeted directory, if the targeted directory does 
  not exist, it creates one in the specified path. All of the files from the monitored
  directory are moved into the targeted directory.  

  .PARAMETER MonitoredFolder
  Specifies the path of the folder that is supposed to be monitored for
  file movement.

  .PARAMETER TargetFolder
  Specifies the path of the target folder that recieves moved files.

  .INPUTS
  None. You can't pipe objects to Monitor-Folder.ps1.

  .OUTPUTS
  None. Monitor-Folder.ps1 doesn't generate any output.

  .EXAMPLE
  PS> .\Monitor-Folder.ps1 -monitoredFolder .\Folder -targetFolder C:\Users\user\Documents\TargetFolder 
#>



#global inputed variables
param(
    [Parameter(Position = 0, Mandatory = $true)][String]$MonitoredFolder, 
    [Parameter(Position = 1, mandatory = $true)][String]$TargetFolder
)

#function that checks if the target folder exists 
function Test-Folder {
    #check if folder exist
    $FlagFolder = Test-Path -Path $TargetFolder
    if ($FlagFolder -ne $true) {
        #create folder if it doesnt exits
        New-Item -ItemType Directory -Path $TargetFolder
    }  
}
#function that moves all files form one folder to the other
function Start-Monitoring{
    $FlagFolder = Test-Path -Path $MonitoredFolder
    if($FlagFolder -eq $true){
        $temp = $MonitoredFolder + "*"
        while($true){
            Move-Item -Path $temp -Destination $TargetFolder
        }
    }
    else{
        Write-Host "The folder you are trying to monitor does not exist."
    }
}

#invoke functions
Test-Folder
Start-Monitoring
