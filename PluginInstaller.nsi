# define installer name
OutFile "GStreamerPluginInstaller_UE5.3.exe"


 
# default section start
Section "Install GStreamerPluginInstaller_UE5.3"
	
	SetRegView 64
	Var /GLOBAL UE5_DIR
	ReadRegStr $UE5_DIR HKLM "Software\EpicGames\Unreal Engine\5.3" "InstalledDirectory"
	#!define INSTDIR $1\Engine\Plugins\Marketplace\GStreamer
	# define output path
	#SetOutPath $INSTDIR 
	#Var /GLOBAL PLUGINDIR
	
	StrCpy $INSTDIR $UE5_DIR\Engine\Plugins\Marketplace\GStreamer
	
	#InstallDirRegKey HKLM "Software\EpicGames\Unreal Engine\5.3" "InstalledDirectory" #previous path (will override default value)
	SetOutPath $INSTDIR
	
	# specify file to go in output path for EngHub Client
	File /r "GStreamer_UE53\*"
	

 
	; Write the installation path into the registry
	WriteRegStr HKLM SOFTWARE\GStreamer_UE53 "Install_Dir" "$INSTDIR"
	; Write the uninstall keys for Windows
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GStreamer_UE53" "DisplayName" "GStreamerPlugin_5.3"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GStreamer_UE53" "UninstallString" '"$INSTDIR\uninstall.exe"'
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GStreamer_UE53" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GStreamer_UE53" "NoRepair" 1
	WriteUninstaller "$INSTDIR\uninstall.exe"

	 
 
#-------
# default section end
SectionEnd
 
# create a section to define what the uninstaller does.
# the section will always be named "Uninstall"
Section "Uninstall"
 

	RMDir /r $INSTDIR
	
	; Remove registry keys
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GStreamerPluginInstaller_UE5.3"
	DeleteRegKey HKLM SOFTWARE\GStreamerPluginInstaller_UE5.3

	

 
SectionEnd