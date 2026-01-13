#scanning the csv file for data
$plik_CSV = Import-Csv -Path .\input_file.csv -Delimiter ";" 
$plik_CSV | Get-Member | Out-Null
$plik_CSV | Format-Table 

#interating through the whole data table
for($i = 0; $i -lt $plik_CSV.Component.length; $i++){
    #message builder
    $out_Message = $plik_CSV.Component[$i]
    $out_Message += ": "
    
    #check if current component output is to be built
    if($plik_CSV.GenerateReport[$i] -eq $true){
        #choose the method of getting the info based on case
        switch($plik_CSV.Component[$i]){
            Computername{
                $out_Message += [Environment]::GetEnvironmentVariable($plik_CSV.Component[$i]) 
                Write-Host $out_Message
            }
            Manufacturer {
                $out_Message += (Get-CimInstance -ClassName Win32_ComputerSystem).Manufacturer
                Write-Host $out_Message
            }
            Model {
                $out_Message += (Get-CimInstance -ClassName Win32_ComputerSystem).Model
                Write-Host $out_Message
            }
            SerialNumber{
                $out_Message += (Get-CimInstance -ClassName Win32_BIOS).SerialNumber
                Write-Host $out_Message
            }
            CpuName{
                $out_Message += (Get-CimInstance -ClassName Win32_Processor).Name
                Write-Host $out_Message
            }
            RAM{
                $out_Message +=  (Get-CimInstance -ClassName Win32_PhysicalMemory).Speed
                Write-Host $out_Message
            }
        }
    }
}


