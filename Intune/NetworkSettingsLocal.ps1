???# Network security: Allow Local System to use computer identity for NTLM
New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\' -Name 'UseMachineId' -Value '1' -PropertyType 'DWORD' ???Force
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\' -Name 'UseMachineId' -Value '1' ???Force

#Network security: Allow LocalSystem NULL session fallback
New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0\' -Name 'allownullsessionfallback' -Value '0' -PropertyType 'DWORD' ???Force
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0\' -Name 'allownullsessionfallback' -Value '0' ???Force

#Network security: Allow PKU2U authentication requests to this computer to use online identities
New-Item -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\' -Name 'pku2u' ???Force
New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\pku2u\' -Name 'AllowOnlineID' -Value '0' -PropertyType 'DWORD' ???Force
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\pku2u\' -Name 'AllowOnlineID' -Value '0' ???Force

#Network security: Do not store LAN Manager hash value on next password change
New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\' -Name 'NoLMHash' -Value '1' -PropertyType 'DWORD' ???Force
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\' -Name 'NoLMHash' -Value '1' ???Force

#Network security: Do not store LAN Manager hash value on next password change
New-Item -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\' -Name 'Kerberos' ???Force
New-Item -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\' -Name 'Parameters' ???Force
New-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\' -Name  'SupportedEncryptionTypes' -Value '2147483640' -PropertyType 'DWORD' ???Force
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\' -Name  'SupportedEncryptionTypes' -Value '2147483640' ???Force
