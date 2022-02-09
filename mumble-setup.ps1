$mumbleUrl = "https://download.mumble.com/en/mumble_client-1.4.230.x64.msi";
$mumbleFileName = "./mumble.msi";
$registerPath = "./registers";

Write-Host "Downloading mumble...";
Invoke-WebRequest $mumbleUrl -OutFile $mumbleFileName; # download mumble
Write-Host "Done";

Write-Host "Installing mumble...";
Start-Process $mumbleFileName -Wait | Out-Null; # Run mumble installer and wait the end
Write-Host "Done";

Write-Host "Import mumble's configuration...";
Get-ChildItem -Path $registerPath -Name | ForEach-Object {
    reg import "$registerPath/$_";
}
Write-Host "Done";

Write-Host -NoNewLine 'Press any key to exit';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');