$ressourcesPath="ressources/1.16.5";
$forgeInstallerFileName="forge-1.16.5-36.2.20-installer.jar";
$mumbleLinkModFileName="$ressourcesPath/mumblelink-1.16.5-4.6.3.jar";
$optiFineModFileName="$ressourcesPath/OptiFine_1.16.5_HD_U_G8.jar";
$modsFolderPath="$env:APPDATA/.minecraft/mods";

Write-Host "Installing forge mod 1.16.5...";
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