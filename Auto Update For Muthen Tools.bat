@echo off
setlocal EnableDelayedExpansion

rem Set your GitHub repository and current version
set "githubRepo=https://github.com/MuthenTools/MuthenToolsv2"
set "currentVersion=1.0"

rem Set the URLs for the version file and the zip archive
set "versionFileURL=%githubRepo%/releases/latest/download/version.txt"
set "updateFileURL=%githubRepo%/releases/latest/download/MuthenToolsv2.zip"


rem Create a temporary directory for downloading updates
set "tempDir=%TEMP%\%programName%_Update"
md "!tempDir!" 2>nul

rem Download the version file
powershell -command "& { Invoke-WebRequest '%versionFileURL%' -OutFile '!tempDir!\version.txt' }"

rem Check if version file exists
if exist "!tempDir!\version.txt" (
    set /p latestVersion=<"!tempDir!\version.txt"

    rem Check if an update is available
    if !latestVersion! gtr !currentVersion! (
        echo New version available: !latestVersion!
        
        rem Download and apply the update
        powershell -command "& { Invoke-WebRequest '%updateFileURL%' -OutFile '!tempDir!\Update.zip' }"
        
        rem Extract the update
        powershell Expand-Archive -Path '!tempDir!\Update.zip' -DestinationPath '!tempDir!\'
        
        rem Replace old files with the updated ones
        xcopy /y /e /q "!tempDir!\*" ".\"
        
        echo Update applied successfully!
    ) else (
        echo Your program is up to date.
    )
) else (
    echo Failed to check for updates. Please try again later.
)

rem Clean up temporary directory
rd /s /q "!tempDir!"

endlocal