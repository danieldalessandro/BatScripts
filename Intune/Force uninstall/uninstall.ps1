# Cria o arquivo de log
$Logfile = "C:\temp\awsremoved.txt"

function WriteLog
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$LogMessage = "$Stamp $LogString"
Add-content $LogFile -value $LogMessage
}

# Getting permissions
Set-ExecutionPolicy Unrestricted

# Pause for 2 secs
Start-Sleep -s 2

# Kill the app
Get-Process AWSVPNClient
Stop-Process -Name "AWSVPNClient" -Force
Get-Process AWSVPNClient.Service.exe
Stop-Process -Name "AWSVPNClient.Service" -Force
Writelog "Process ended"

# Get username
$user = $env:USERPROFILE.Split('\')[-1]

# Desinstala o app usando o msi
msiexec /x "AWS_VPN_Client.msi" /qn
Writelog "App removed"

# Remove de folders recursively
Remove-Item -path "C:\Program Files\Amazon\AWS VPN Client" -recurse -force

# caso necessário descomentar a linha abaixo pra remover o perfil.
# Remove-Item -path $env:USERPROFILE\AppData\Roaming\AWSVPNClient\ConnectionProfiles -recurse -force
Remove-Item -recurse -force -Path "c:\temp\profilelog.txt"
Writelog "Removed files"

# Seta a pasta da vpn
$folderPath = "C:\Program Files\Amazon\AWS VPN Client\"

# Verifica se a pasta existe
if (Test-Path -Path $folderPath -PathType Container) {
    # Pasta existe, exibe mensagem de erro
    Writelog "A pasta $folderPath n�o foi exclu�da."
    exit 1
}
else {
    # Pasta não existe, termina com sucesso
    Writelog "A pasta $folderPath n�o existe. Encerrando com sucesso."
    exit 0
}