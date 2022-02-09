$ressourcesPath="ressources/1.17.1";
$forgeInstallerFileName="forge-1.17.1-37.1.1-installer.jar";
$mumbleLinkModFileName="$ressourcesPath/mumblelink-1.17.1-5.1.0.jar";
$optiFineModFileName="$ressourcesPath/OptiFine_1.17.1_HD_U_H1.jar";
$modsFolderPath="$env:APPDATA/.minecraft/mods";

Write-Host "Installing forge mod 1.17.1...";
Start-Process "$ressourcesPath/$forgeInstallerFileName" -Wait | Out-Null; # Run forge installer
Write-Host "Done";

Write-Host "Copying mods...";
Remove-Item "$modsFolderPath/mumblelink*";
Remove-Item "$modsFolderPath/OptiFine*";
Copy-Item $mumbleLinkModFileName "$modsFolderPath/." ;
Copy-Item $optiFineModFileName "$modsFolderPath/." ;
Write-Host "Done";

Write-Host -NoNewLine 'Press any key to exit';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');