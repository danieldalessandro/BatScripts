???New-Item -Path c:\temp -ItemType Directory -Force -Confirm:$false | out-null


$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("URL")

Expand-Archive -Path c:\temp\kasperskyav.zip -DestinationPath c:\temp

Start-Process -Wait -FilePath "C:\temp\Setup.exe" -ArgumentList "/S" -PassThru


