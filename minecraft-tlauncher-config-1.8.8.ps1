$ressourcesPath="ressources/1.8.8";
$forgeInstallerFileName="forge-1.8.8-11.15.0.1655-installer.jar";
$mumbleLinkModFileName="$ressourcesPath/MumbleLink-1.8.8-4.1.3.jar";
$optiFineModFileName="$ressourcesPath/OptiFine_1.8.8_HD_U_I7.jar";
$modsFolderPath="$env:APPDATA/.minecraft/mods";

Write-Host "Copying mods...";
Copy-Item $mumbleLinkModFileName "$modsFolderPath/." ;
Copy-Item $optiFineModFileName "$modsFolderPath/." ;
Write-Host "Done";

Write-Host -NoNewLine 'Press any key to exit';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');