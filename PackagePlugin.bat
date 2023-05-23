@echo off
REM SetupScript Juergen Riegel juergen.riegel@daimler.com
echo  [32mDeploy project.[0m

FOR /F "tokens=2* skip=2" %%a in ('reg query "HKLM\Software\EpicGames\Unreal Engine\5.1" /v "InstalledDirectory"') do set UE_51_DIR=%%b

echo  Using:%UE_51_DIR%


IF "%UE_51_DIR%"=="" (
    ECHO [91mERROR: UE_51_DIR environment variable not set!! [0m
    ECHO Install Unreal 5.1 via EpicGame launcher!
    pause
    exit 1
)


echo  [94mSearch for NSIS:[0m
WHERE makensis
IF %ERRORLEVEL% NEQ 0 (
    ECHO [91mERROR: makensis.exe whas not found in path! Download and install NSIS first! [0m
    ECHO See: https://nsis.sourceforge.io/Download on details for you system.
    pause
    exit 1
)


SET CURRENTDIR="%cd%"


call "%UE_51_DIR%/Engine/Build/BatchFiles/RunUAT.bat" BuildPlugin ^
                -plugin=%CURRENTDIR%\Plugins\GStreamer\GStreamer.uplugin ^
                -Package=%CURRENTDIR%\GStreamer_UE51 ^
				-TargetPlatforms=Win64
IF %ERRORLEVEL% NEQ 0 (
    ECHO [91mERROR: Building Plugin failed! [0m
    pause
    exit 1
)

makensis.exe -V4 PluginInstaller.nsi
IF %ERRORLEVEL% NEQ 0 (
    ECHO [91mERROR: Building Installer failed! [0m
    pause
    exit 1
)

