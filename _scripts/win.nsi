# define name of installer
OutFile "drops\Rocket-Installer.exe"
 
# define installation directory
InstallDir "$ProgramFiles\Rocket"
 
# For removing Start Menu shortcut in Windows 7
RequestExecutionLevel admin

 
# start default section
Section
    # set the installation directory as the destination for the following actions
    SetOutPath $INSTDIR

    SetOverwrite on
    File /r "D:\_repos\rocket\build\windows\runner\Release\*"
 
    # create the uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"
 
    # create a shortcut named "new shortcut" in the start menu programs directory
    # point the new shortcut at the program uninstaller
    CreateShortcut "$SMPROGRAMS\Rocket.lnk" "$INSTDIR\rocket.exe"
    Exec "$INSTDIR\rocket.exe"
    Quit
SectionEnd
 
# uninstaller section start
Section "uninstall"
 
    # first, delete the uninstaller
    Delete "$INSTDIR\uninstall.exe"
 
    # second, remove the link from the start menu
    Delete "$SMPROGRAMS\Rocket.lnk"
 
    RMDir $INSTDIR
# uninstaller section end
SectionEnd