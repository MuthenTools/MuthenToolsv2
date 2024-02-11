@echo off
title Muthen Tools V6 -UNSTABLE BETA-
setlocal EnableDelayedExpansion

rem Set your GitHub repository and current version
set "githubRepo=https://github.com/MuthenTools/MuthenToolsv2"
set "currentVersion=6.1"

rem Set the URLs for the version file and the zip archive
set "versionFileURL=%githubRepo%/releases/latest/download/version.txt"
set "updateFileURL=%githubRepo%/releases/latest/download/MuthenToolsV6.1.zip"

:loadColor
rem Load the color from the file if it exists
if exist color.txt (
    set /p colorCode=<color.txt
) else (
    rem Default to color 7 (white) if the file doesn't exist
    set "colorCode=7"
)

rem Set the font color using the color command
color %colorCode%

:menu
cls
echo ============================
echo      Muthen Tools
echo ============================
echo 1. Task Manager
echo 2. Command Prompt
echo 3. File Explorer
echo 4. Notepad
echo 5. System Configuration
echo 6. Control Panel
echo 7. Registry Editor (note: be careful while using regedit; it can damage your OS!)
echo 8. PowerShell
echo 9. Open Explorer at Current Location
echo 10. System Information
echo 11. Control Panel (Admin)
echo 12. Device Manager
echo 13. Windows Update Settings
echo 14. Change Font Color
echo 15. Check for Updates
echo 16. Exit
echo 17. Background Color Changer
echo 18. Custom Script Runner
echo 19. Website Opener

set /p choice=Enter the number of the tool you want to open: 

rem Use quotes to avoid issues with empty input or spaces
if "%choice%"=="1" goto taskmgr
if "%choice%"=="2" goto cmd
if "%choice%"=="3" goto explorer
if "%choice%"=="4" goto notepad
if "%choice%"=="5" goto msconfig
if "%choice%"=="6" goto control
if "%choice%"=="7" goto regedit
if "%choice%"=="8" goto powershell
if "%choice%"=="9" goto openExplorer
if "%choice%"=="10" goto systemInfo
if "%choice%"=="11" goto controlPanelAdmin
if "%choice%"=="12" goto deviceManager
if "%choice%"=="13" goto updateSettings
if "%choice%"=="14" goto colorMenu
if "%choice%"=="15" goto checkUpdates
if "%choice%"=="16" goto :eof
if "%choice%"=="17" goto option17
if "%choice%"=="18" goto option18
if "%choice%"=="19" goto option19

:taskmgr
start taskmgr
goto menu

:cmd
start cmd
goto menu

:explorer
start explorer
goto menu

:notepad
start notepad
goto menu

:msconfig
start msconfig
goto menu

:control
start control
goto menu

:regedit
start regedit
goto menu

:powershell
start powershell
goto menu

:openExplorer
start explorer .
goto menu

:systemInfo
msinfo32
goto menu

:controlPanelAdmin
start "Control Panel" control /name Microsoft.AdministrativeTools
goto menu

:updateSettings
start ms-settings:windowsupdate
goto menu

:colorMenu
cls
echo Choose a color for the font:
echo 0. Black
echo 1. Blue
echo 2. Green
echo 3. Cyan
echo 4. Red
echo 5. Magenta
echo 6. Yellow
echo 7. White

set /p colorChoice=Enter the number of the color you want: 

rem Save the selected color to the file
echo %colorChoice% > color.txt

rem Set the font color using the color command
color %colorChoice%
goto menu

:checkUpdates
echo Checking for updates...

rem Check internet connectivity
ping -n 1 google.com >nul
if not !errorlevel! equ 0 (
    echo Unable to check for updates. Please ensure you have an active internet connection.
    goto menu
)

rem Download the version file
powershell -command "& { Invoke-WebRequest '%versionFileURL%' -OutFile 'version.txt' }"

rem Check if version file exists
if exist "version.txt" (
    set /p latestVersion=<"version.txt"

    rem Check if an update is available
    if !latestVersion! gtr !currentVersion! (
        echo New version available: !latestVersion!
        echo Do you want to apply the update now? (Y/N)
        set /p applyUpdate=

        if /i !applyUpdate! equ "Y" (
            echo Applying the update...
            
            rem Download and apply the update
            powershell -command "& { Invoke-WebRequest '%updateFileURL%' -OutFile 'Update.zip' }"
            
            rem Extract


:option19
cls
echo Enter the website URL (https://websiteurl):
set /p websiteURL=

rem Launch the default browser with the specified URL
start "" "%websiteURL%"
goto menu


:option17
cls
echo Choose a color for the background:
echo 0. Black
echo 1. Blue
echo 2. Green
echo 3. Cyan
echo 4. Red
echo 5. Magenta
echo 6. Yellow
echo 7. White

set /p bgColorChoice=Enter the number of the color you want: 

rem Save the selected background color to the file
echo %bgColorChoice% > bgColor.txt

rem Set the background color using the color command
color %colorChoice%%bgColorChoice%
goto menu

:option18
cls
echo Enter the custom script or command:
set /p customScript=

rem Execute the custom script
%customScript%
goto menu



