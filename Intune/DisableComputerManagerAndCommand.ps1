???#Disable Computer Management
New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\' -Name 'Explorer' ???Force
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name  'NoManageMyComputerVerb' -Value '1' -PropertyType 'DWORD' ???Force
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name  'NoManageMyComputerVerb' -Value '1' ???Force

#Disable Command Run
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V NoRun /t REG_DWORD /d 1
