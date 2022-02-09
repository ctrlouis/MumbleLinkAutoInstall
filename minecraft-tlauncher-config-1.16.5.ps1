$ressourcesPath="ressources/1.16.5";
$mumbleLinkModFileName="$ressourcesPath/mumblelink-1.16.5-4.6.3.jar";
$modsFolderPath="$env:APPDATA/.minecraft/mods";

Write-Host "Copying mods...";
Remove-Item "$modsFolderPath/mumblelink*";
Copy-Item $mumbleLinkModFileName "$modsFolderPath/." ;
Write-Host "Done";

Write-Host -NoNewLine 'Press any key to exit';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');