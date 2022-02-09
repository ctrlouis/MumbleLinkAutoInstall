$ressourcesPath="ressources/1.8.8";
$mumbleLinkModFileName="$ressourcesPath/MumbleLink-1.8.8-4.1.3.jar";
$modsFolderPath="$env:APPDATA/.minecraft/mods";

Write-Host "Copying mods...";
Remove-Item "$modsFolderPath/mumblelink*";
Copy-Item $mumbleLinkModFileName "$modsFolderPath/." ;
Write-Host "Done";

Write-Host -NoNewLine 'Press any key to exit';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');