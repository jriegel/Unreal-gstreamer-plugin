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

SET CURRENTDIR="%cd%"


call "%UE_51_DIR%/Engine/Build/BatchFiles/RunUAT.bat" BuildPlugin ^
                -plugin=%CURRENTDIR%\Plugins\GStreamer\GStreamer.uplugin ^
                -Package=%CURRENTDIR%\GStreamer_5.1 ^
				-TargetPlatforms=Win64
