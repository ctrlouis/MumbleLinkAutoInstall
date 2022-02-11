$availableVersions = @('1.8.8', '1.16.5', '1.17.1')
$minecraftFolderPath = "$env:APPDATA/.minecraft";
$modsFolderPath = "$env:APPDATA/.minecraft/mods";
$mumbleUrl = "https://download.mumble.com/en/mumble_client-1.4.230.x64.msi";
$mumbleFileName = "./mumble.msi";
$tempFolderName = "temp";
$tempFolderPath = "./$tempFolderName";
$registerPath = "./registers";
$ressourcesPath = "./ressources";


function Download-Mumble {
    Write-Host "";
    Write-Host "Telechargement de l'installeur de Mumble en cours...";
    (New-Object System.Net.WebClient).DownloadFile($mumbleUrl, "$tempFolderPath/$mumbleFileName"); # download mumble
    Write-Host "Telechargement de l'installeur de Mumble termine";
}

function Install-Mumble {
    Write-Host "";
    Write-Host "Installation de Mumble... (Veuillez suivre les instructions de l'installeur)";
    Start-Process "$tempFolderPath/$mumbleFileName" -Wait | Out-Null; # Run mumble installer and wait the end
    Write-Host "Installation de Mumble termine";
}

function Setup-Mumble {
    Write-Host "";
    Write-Host "Import de la configuration de Mumble...";
    Get-ChildItem -Path $registerPath -Name | ForEach-Object {
        reg import "$registerPath/$_";
    }
    Write-Host "Import de la configuration de Mumble termine";
}

function Setup-Minecraft {
    $currentVersionRessourcesPath = "$ressourcesPath/$minecraftVersion";
    $forgeInstallerFileName = Get-ChildItem -Path $currentVersionRessourcesPath -Name "forge*";
    $mumbleLinkModFileName = Get-ChildItem -Path $currentVersionRessourcesPath -Name "mumble*";
    $optiFineModFileName = Get-ChildItem -Path $currentVersionRessourcesPath -Name "optifine*";
    
    if ($launcherType -eq 1) {
        Write-Host "";
        Write-Host "Installation de forge $minecraftVersion... (Veuillez suivre les instructions de l'installeur)";
        Start-Process "$currentVersionRessourcesPath/$forgeInstallerFileName" -Wait | Out-Null; # Run forge installer
        Write-Host "Termine";
    }

    Write-Host "Deplacement des mods dans le dossier '$modsFolderPath'...";
    New-Item -Path "$minecraftFolderPath" -Name "mods" -ItemType "directory" -Force | Out-Null; # Create temp folder
    if ($launcherType -eq 1) {
        Remove-Item "$modsFolderPath/OptiFine*";
        Copy-Item "$currentVersionRessourcesPath/$optiFineModFileName" "$modsFolderPath/." ;
    }
    Remove-Item "$modsFolderPath/mumblelink*";
    Copy-Item "$currentVersionRessourcesPath/$mumbleLinkModFileName" "$modsFolderPath/." ;
    Write-Host "Termine";
}

function Wait-Escape {
    Write-Host "";
    Write-Host "Appuyer sur une touche pour quitter";
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}

function Main {
    Write-Host "Mumble Link Auto Installer";

    New-Item -Path "." -Name "$tempFolderPath" -ItemType "directory" -Force | Out-Null; # Create temp folder
    
    Write-Host "";
    $question = "Voulez vous installer Mumble ?";
    $choices = '&Oui', '&Non';
    $installMumble = $Host.UI.PromptForChoice("", $question, $choices, 1);
    
    Write-Host "";
    $question = "Voulez vous configurer Mumble ? (Configuration du chat de proximite)";
    $choices = '&Oui', '&Non';
    $setupMumble = $Host.UI.PromptForChoice("", $question, $choices, 1);

    Write-Host "";
    $question = "Voulez vous configurer Minecraft ? (Configuration du chat de proximite)";
    $choices = '&Oui', '&Non';
    $setupMinecraft = $Host.UI.PromptForChoice("", $question, $choices, 1);

    if ($setupMinecraft -eq 0) {
        Write-Host "";
        Write-Host "Selectionnez votre type de launcher : (saisissez le nombre correspondant)";
        Write-Host '[1] Minecraft Officiel';
        Write-Host '[2] Minecraft Tlauncher';
        Write-Host '[0] Annuler';
        $launcherType = Read-Host "Type de launcher";
        
        if ($launcherType -gt 0) {
            Switch ($launcherType) {
                1 { $launcherTypeName = "Minecraft Officiel" }
                2 { $launcherTypeName = "Minecraft Tlauncher" }
            }
            Write-Host "Vous avez choisi le launcher $launcherTypeName";

            Write-Host "";
            Write-Host "Selectionnez la version du jeux a configurer : (saisissez le nombre correspondant)";
            $i = 1;
            Foreach ($version in $availableVersions) {
                Write-Host "[$i] $version";
                $i = $i + 1;
            }
            Write-Host "[0] Annuler";
            $selectMinecraftVersion = Read-Host "Version de Minecraft";

            if ($selectMinecraftVersion -gt 0) {
                $minecraftVersion = $availableVersions[$selectMinecraftVersion-1];
                Write-Host "Vous avez choisi le launcher $launcherTypeName";
                Write-Host "Vous avez choisi la version $minecraftVersion";
            }
        }
    }

    # Download and install Mumble
    if ($installMumble -eq 0) {
        Download-Mumble;
        Install-Mumble;
    }

    # Setup Mumble (proximity chat)
    if ($setupMumble -eq 0) {
        Setup-Mumble;
    }

    if (($setupMinecraft -eq 0) -and ($launcherType -gt 0) -and ($selectMinecraftVersion -gt 0)) {
        Setup-Minecraft;
    }
}

Main;
Wait-Escape;
