#deklaracja zmiennych globalnych
$flag1 = $false
$flag2 = $false
$userName = "admin"
$password = ConvertTo-SecureString -String "pass" -AsPlainText -Force

#petla sprawdzania uzytkownika
while($flag1 -eq $false) {
    #pobieranie uzytkownika
    $userChk = Read-Host "Podaj uzytkownika" 
    if($userName -eq $userChk){
        #przerwanie while
        $flag1 = $true
        break
    }
    Write-Host "Bledny uzytkownik" 
}
#petal sprawdzania hasla
while ($flag2 -eq $false) {
    #pobieranie hasla
    $passwordChk = Read-Host "Podaj haslo" -AsSecureString
    #konwersja w odczytywalny format
    $var1 = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwordChk)
    $password_Chk_Readable = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($var1)
    
    $var2 = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $password_Readable = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($var2)
    #porownianie hasel
    if($password_Readable -ceq $password_Chk_Readable){
        #przerwanie while
        $flag2 = $true
        break
    }
    Write-Host "Bledne haslo"
}

#informacja zwrotna
if(($flag1 -eq $true) -and ($flag2 -eq $true)){
    Write-Host "Pomyslne logowanie"
}