@echo off
title koyu's preinstall script for Windows
color 17
cd %~dp0
rd /s/q cache
rd /s/q Office
taskkill /IM office.exe /f
mkdir cache
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
cls
cd %~dp0

:choice
cls
title koyu's preinstall script for Windows
echo Profiles: basic, gaming, office, libresuite, burner, startisback, spotify, disable
set /P c=Enter profiles or quit to quit: 
if /I "%c%" EQU "basic" goto :basic
if /I "%c%" EQU "gaming" goto :gaming
if /I "%c%" EQU "office" goto :office
if /I "%c%" EQU "libresuite" goto :libresuite
if /I "%c%" EQU "burner" goto :burner
if /I "%c%" EQU "startisback" goto :startisback
if /I "%c%" EQU "spotify" goto :spotify
if /I "%c%" EQU "disable" goto :disable
if /I "%c%" EQU "quit" goto :quit
goto choice

:quit
rd /s/q cache
rd /s/q Office
exit

:basic
echo Installing basic profile...
choco feature enable -n=allowGlobalConfirmation
choco install adobereader googlechrome 7zip avastfreeantivirus discord filezilla gimp inkscape irfanview notepadplusplus putty python3 qbittorrent teamviewer teracopy vlc vscode winscp lockhunter nextcloud-client joplin signal
choco feature disable -n=allowGlobalConfirmation
goto choice

:gaming
echo Installing gaming profile...
choco feature enable -n=allowGlobalConfirmation
choco install wget steam epicgameslauncher valorant
choco feature disable -n=allowGlobalConfirmation
wget -O cache\battlenet.exe "https://eu.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe&id=undefined"
cache\battlenet.exe --lang=enUS --installpath="C:\Program Files (x86)\Battle.net"
goto choice

:office
echo Installing office profile...
echo Hint: Alternatively you can install the libresuite profile for a free software alternative to Microsoft Office
set /P d=Do you agree to Microsoft's EULA for Office [y/n]? 
if /I "%d%" EQU "y" goto continueoffice
if /I "%d%" EQU "n" goto choice
goto choice

:continueoffice
echo Now downloading and installing office. This may take a couple of minutes...
office.exe /download Office365.xml
office.exe /configure Office365.xml
rd /s/q Office

:burner
echo Installing burner profile...
choco feature enable -n=allowGlobalConfirmation
choco install imgburn
choco feature disable -n=allowGlobalConfirmation
goto choice

:startisback
echo Installing startisback profile...
choco feature enable -n=allowGlobalConfirmation
choco install wget
choco feature disable -n=allowGlobalConfirmation
wget -O cache\startisback.exe https://startisback.sfo3.cdn.digitaloceanspaces.com/StartIsBackPlusPlus_setup.exe
cache\startisback.exe /elevated /silent
goto choice

:spotify:
echo Installing spotify profile...
choco feature enable -n=allowGlobalConfirmation
choco install spotify
choco feature disable -n=allowGlobalConfirmation
goto choice

:disable
echo Installing disable profile...
DISM /Online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64 /norestart
DISM /Online /Disable-Feature /FeatureName:WindowsMediaPlayer /norestart
goto choice

:libresuite
echo Installing libresuite profile...
choco feature enable -n=allowGlobalConfirmation
choco install libreoffice thunderbird
choco feature disable -n=allowGlobalConfirmation