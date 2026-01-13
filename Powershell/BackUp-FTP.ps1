 <#
  .SYNOPSIS
  Connects to a server through FTP and uploads a file.

  .DESCRIPTION
  BackUp-FTP.ps1 connects to a specified FTP server with given credentials,
  and uploads a file which is specified in the prompt. The file is turned to
  a zip file and then uploaded to a dir in FTP server.
  
  .INPUTS
  None. You can't pipe objects to BackUp-FTP.ps1

  .OUTPUTS
  Outputs "Successful upload" when correctly uploaded.

  .EXAMPLE
  PS> .\BackUp-FTP.ps1
  Provide file path of files: [File path]
  Provide file name on the server: [File name]    
  Provide FTP server name: [Server name]
  Provide FTP username: [Username]
  Provide FTP user password: [Password]
  
#>
function Send-FTPArchive(){
    #setting parameters of the function
    param([Parameter(position=0, mandatory=$true)][String]$archiveFilePath,
    [Parameter(position=1, mandatory=$true)][String]$FTPServerName,
    [Parameter(position=2, mandatory=$true)][String]$FTPServerUsername,
    [Parameter(position=3, mandatory=$true)][SecureString]$FTPUserPassword,
    [Parameter(position=4, mandatory=$true)][String]$FTPFileName) 

    #FTP user password from SecureString conversion
    $FTPUserPasswordPlain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($FTPUserPassword))


    #archive files before transfer
    $compress = @{
        Path = $archiveFilePath
        CompressionLevel = "Fastest"
        DestinationPath = "./FTPReadyArchive.zip"
    }

    #compress chosen files
    Compress-Archive @compress -Force

    #target dir on the server path specified
    $FTPTargetDir = "/FTPTarget/"
    $FTPServerPath = "ftp://" + $FTPServerName + $FTPTargetDir + $FTPFileName
    
    #Creation of FTPRequest
    $FTPRequest = [System.Net.FtpWebRequest]::Create("$FTPServerPath")
    $FTPRequest.Credentials = New-Object System.Net.NetworkCredential($FTPServerUsername, $FTPUserPasswordPlain)
    $FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
    $FTPRequest.UsePassive = $true

    #Upload files to FTP server
    $archiveFileRead = [System.IO.File]::ReadAllBytes($compress.DestinationPath)
    $FTPRequestStream = $FTPRequest.GetRequestStream()
    $FTPRequestStream.Write($archiveFileRead, 0, $archiveFileRead.Length)
    $FTPRequestStream.Close()
    Write-Host "Upload successful!"
}


#file archive source and local save destination
$arg1 = Read-Host "Provide file path of files"
$arg5 = Read-Host "Provide file name on the server"

#prompting user for the credentials
$arg2 = Read-Host "Provide FTP server name"
$arg3 = Read-Host "Provide FTP username"
$arg4 = Read-Host "Provide FTP user password" -AsSecureString


#starting the function
Send-FTPArchive -archiveFilePath $arg1 -FTPServerName $arg2 -FTPServerUsername $arg3 -FTPUserPassword $arg4 -FTPFileName $arg5
