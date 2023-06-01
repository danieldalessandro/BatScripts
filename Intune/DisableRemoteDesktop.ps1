???#Disable remote desktop
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name  'fDenyTSConnections' -Value '1' ???Force
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name  'updateRDStatus' -Value '0' ???Force
