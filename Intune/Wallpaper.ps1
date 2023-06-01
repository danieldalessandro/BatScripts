$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"
$StatusValue = "1"
$url = "https://s3.amazonaws.com/address.s3.com.br/files/Windows_Wallpaper/wallpaper.jpg"
$DesktopImageValue = "C:\temp\wallpaperw7c.jpg"
$directory = "C:\temp\"
If ((Test-Path -Path $directory) -eq $false)
{
New-Item -Path $directory -ItemType directory
}
Invoke-WebRequest -Uri $url -OutFile $DesktopImageValue
if (!(Test-Path $RegKeyPath))
{
Write-Host "Creating registry path $($RegKeyPath)."
New-Item -Path $RegKeyPath -Force | Out-Null
}
New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
RUNDLL32.EXE USER32.DLL, UpdatePerUserSystemParameters 1, True 
