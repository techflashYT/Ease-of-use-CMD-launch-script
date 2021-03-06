:: Sets the color, disables command feedback, and clears the screen of the version and whatnot text.
:Init
@echo off
cls
cd %appdata%
set blank=
:: Debug stuff, making a place for logs
if exist "Sanikdah Software" (
	cd "Sanikdah Software".
	goto :SSFolderExists
) else (
	mkdir "Sanikdah Software".
	cd "Sanikdah Software".
	goto :SSFolderExists
)
	
:SSFolderExists
if exist "Ease of Use Command Prompt Auto Run Script" (
	cd "Ease of Use Command Prompt Auto Run Script"
	goto :EoUCPARS-FolderExists
) else (
	mkdir "Ease of Use Command Prompt Auto Run Script"
	cd "Ease of Use Command Prompt Auto Run Script"
	goto :FirstTimeUser
)
:EoUCPARS-FolderExists
@echo off
if exist AutoRunWithCMD.cmd (
	copy AutoRunWithCMD.cmd %temp%\AutoRunWithCMD.cmd > nul
) else (
	echo.Can't find the this script!!  
)

if exist Log.txt.old (
	del /f Log.txt.old
)
:: Rename the log to Log.txt.old
if exist Log.txt (
	ren Log.txt Log.txt.old
)
move %temp%\AutoRunWithCMD.cmd "%appdata%\Sanikdah Software\Ease of Use Command Prompt Auto Run Script\AutoRunWithCMD.cmd" > nul
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
echo %mydate%:%mytime%		Started the program > Log.txt
goto :ReadBackColor

:ReadBackColor
@echo off
set /p color= < Color.txt
ping techflash.ga -n 1 > nul
color %color%
goto :MainMenu


:: Launches if the previous code detects that this is your first time launching the program
:FirstTimeUser
@echo off
if exist AutoRunWithCMD.cmd (
	copy AutoRunWithCMD.cmd %temp%\AutoRunWithCMD.cmd > nul
) else (
	echo.Can't find the this script!!  
)
move %temp%\AutoRunWithCMD.cmd "%appdata%\Sanikdah Software\Ease of Use Command Prompt Auto Run Script\AutoRunWithCMD.cmd" > nul
cls

:FirstTimeUser1.5
echo.Hey!  Would you like this program to run whenever you launch the command prompt?
echo.(Please note that this is dangerous and will break any other batch script.)
echo.You can ALSO try a safer method, where calling a command in CMD will launch the script.
echo.Which would you like to do?
echo.N/n: Nothing
echo.D/d: Dangerous but more convinient method.
echo.S/s: Safer method.
set /p doesAutoRun=
if not '%doesAutoRun%'=='' set doesAutoRun=%doesAutoRun:~0,1%
if '%doesAutoRun%'=='D' goto :setAutoRun
if '%doesAutoRun%'=='d' goto :setAutoRun
if '%doesAutoRun%'=='n' goto :FirstTimeUser2
if '%doesAutoRun%'=='N' goto :FirstTimeUser2
if '%doesAutoRun%'=='S' goto :saferSetAutoRun
if '%doesAutoRun%'=='s' goto :saferSetAutoRun
echo."%doesAutoRun%" is not valid, please try again.
goto :FirstTimeUser

:: Sets the autoRun value
:setAutoRun
@echo off
cls
echo. Are you CERTAIN that you want to do this?  It is difficult to undo!
set /p isSureOfDangerousAutoRun=
if not '%isSureOfDangerousAutoRun%'=='' set isSureOfDangerousAutoRun=%isSureOfDangerousAutoRun:~0,1%
if '%isSureOfDangerousAutoRun%'=='Y' goto :setAutoRun2
if '%isSureOfDangerousAutoRun%'=='y' goto :setAutoRun2
if '%isSureOfDangerousAutoRun%'=='n' goto :FirstTimeUser
if '%isSureOfDangerousAutoRun%'=='N' goto :FirstTimeUser
echo."%isSureOfDangerousAutoRun%" is not valid, please try again.
goto :setAutoRun

:setAutoRun2
@echo off
echo.This will NOT work if you have renamed the file.  Will work on fixing that by 0.1!
reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_EXPAND_SZ /d "%appdata%/Sanikdah Software/AutoRunWithCMD.cmd" /f > nul
goto :setAutoRun2

:saferSetAutoRun
@echo off
cls
echo.This will append the directory of the file to your system PATH, so you can run it with a command.
echo.==WARNING======WARNING=====WARNING===
echo.==WARNING======WARNING=====WARNING===
echo.==WARNING======WARNING=====WARNING===
echo.While I am pretty sure that this is safe, it still messes with your system PATH.
echo.Using IN-DEVELOPMENT CODE.
echo.By aggreeing to add this to your system path, you are aggreeing that your system might not boot afterwards.
echo.Or it might have other side effects, I know for a fact that I made a restore point before doing this.
echo.
echo.S/s: Open the GUI to make a system restore point before attempting this.
echo.C/c: Continue without making a restore point (or if you have already made one).
echo.1: Go back.
set /p choiceForDangerousAutoRun=
if not '%choiceForDangerousAutoRun%'=='' set choiceForDangerousAutoRun=%choiceForDangerousAutoRun:~0,1%
if '%choiceForDangerousAutoRun%'=='s' goto :MakeSystemRestorePoint
if '%choiceForDangerousAutoRun%'=='S' goto :MakeSystemRestorePoint
if '%choiceForDangerousAutoRun%'=='C' goto :saferSetAutoRun2
if '%choiceForDangerousAutoRun%'=='c' goto :saferSetAutoRun2
if '%choiceForDangerousAutoRun%'=='1' goto :FirstTimeUser
cls
echo."%choiceForDangerousAutoRun%" is not a valid option, please try again.
echo.
goto :saferSetAutoRun

:saferSetAutoRun2
@echo off
cls
set AppendToPath='%appdata%\Sanikdah Software\Ease of Use Command Prompt Auto Run Script'
echo.Wasting time so that we are 100% certain that the variable has updated before continuing,  please wait.....
ping techflash.ga -n 6 > nul
:: Wastes time so that the variable 100% has enough time to update to prevent breaking of computers.
echo.Setting everything...
set "PATH=%AppendToPath%;%PATH%"
echo.Done!  Please save any work and restart your computer for it to work!
echo.Would you like to have the script restart your PC for you?
set /p doesRestart=
if not '%doesRestart%'=='' set doesRestart=%doesRestart:~0,1%
if '%doesRestart%'=='y' (
	shutdown /t 20 /r
	echo.Restarting in 20 seconds!
)
if '%doesRestart%'=='Y' (
	shutdown /t 20 /r
	echo.Restarting in 20 seconds!
)
if '%doesRestart%'=='n' (
	echo.Going back to the menu!
	timeout 5
	cls
	goto :MainMenu
)
if '%doesRestart%'=='N' (
	echo.Going back to the menu!
	timeout 5
	cls
	goto :MainMenu
)
cls
echo."%doesRestart%" is not a valid option, please try again.
echo.
goto :saferSetAutoRun2


:FirstTimeUser2
@echo off
title Do you want a tutorial?
echo.Hey!  You seem like you ran this program for the first time!  Would you like a tutorial on how to use the program?
set /p wantsTutorial= 
if not '%wantsTutorial%'=='' set wantsTutorial=%wantsTutorial:~0,1%
if '%wantsTutorial%'=='y' goto :wantsTutorial
if '%wantsTutorial%'=='Y' goto :wantsTutorial
if '%wantsTutorial%'=='n' goto :noTutorial
if '%wantsTutorial%'=='N' goto :noTutorial
ECHO. "%wantsTutorial%" is not a valid option, please try again.
goto :FirstTimeUser
ECHO.

:wantsTutorial
echo.Placeholder tutorial.
echo.Do you want to see the tutorial again?
set /p wantsTutorial= 
if not '%wantsTutorial%'=='' set wantsTutorial=%wantsTutorial:~0,1%
if '%wantsTutorial%'=='y' goto :wantsTutorial
if '%wantsTutorial%'=='Y' goto :wantsTutorial
if '%wantsTutorial%'=='n' goto :noTutorial
if '%wantsTutorial%'=='N' goto :noTutorial
if '%wantsTutorial%'=='no' goto :noTutorial
if '%wantsTutorial%'=='No' goto :noTutorial
cls
echo."%wantsTutorial%" is not a valid option, please try again.
echo.
goto :FirstTimeUser


:noTutorial
echo.Are you sure?
set /p isSureofNoTutorial= 
if not '%isSureofNoTutorial%'=='' set isSureofNoTutorial=%isSureofNoTutorial:~0,1%
if '%isSureofNoTutorial%'=='y' goto :isSureofNoTutorial
if '%isSureofNoTutorial%'=='Y' goto :isSureofNoTutorial
if '%isSureofNoTutorial%'=='n' goto :FirstTimeUser
if '%isSureofNoTutorial%'=='N' goto :FirstTimeUser
cls
echo."%isSureofNoTutorial%" is not a valid option, please try again.
echo.
goto :noTutorial


:isSureofNoTutorial
cls
echo Alright, just go to Help (5) and then Tutorial (2) to view it if you ever want to!
goto :MainMenu


:: Main menu code, sets the title, adds 2 blank lines, and eventually a working choice system.
:MainMenu
@echo off
title Welcome!  What would you like to do?
echo.
echo This is a placeholder menu until I design a real one!
goto :Choice
echo.>MainMenuTriggered.txt

:ClearAndMenu
@echo off
cls
goto :MainMenu

:: Some code to make choices
:: NOTE TO FUTURE SELF:
:: For some reason this code only allows for a SINGLE character to be used as a choice thingy, so like, 0-9 is fine, but not 10, etc.
:Choice
set choice=
echo.
echo.  1: Go to the regular command line and run your own commands!
echo.  2: Test your internet connection by pinging Google!
echo.  3: Repair your system by running DISM and System File Checker!
echo.  4: Get your public IP!
echo.  5: Check network statistics!
echo.  8: Settings
echo.  9: Access Help
echo.Which do you want?
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto :GoToRegularCMD
if '%choice%'=='2' goto :PingGoogle
if '%choice%'=='3' goto :DISMandSFC
if '%choice%'=='4' goto :CurlIPme
if '%choice%'=='5= goto :CheckNetworkStatistics
if '%choice%'=='0' goto :debug
if '%choice%'=='8' goto :Settings
if '%choice%'=='9' goto :Help
cls
echo."%choice%" is not a valid option, please try again.
echo.
goto :Choice
echo.>EndOfChoiceTriggered.txt

:: Some code to launch the restore point UI
:MakeSystemRestorePoint
@echo off
echo.Starting the GUI...
start "" sysdm.cpl
echo.Done!
echo.A few steps now.
echo.1. Click on "System Protection".
echo.1.5 If System Protection is disabled, enable it.
echo.2. Click on "Create".
echo.3. Go through the steps of creating the restore point.
echo.Press any key when you are done.
pause
goto :ClearAndMenu

:DISMandSFC
@echo off
echo.This will ask you to run System File Checker
echo.as an administrator.
echo.
echo.When you are ready, press any key.
pause
powershell "start sfc /scannow -v runAs"
echo.When that is finished, press any key.
pause
echo.
echo.Currently unable to run DISM, you will have to do it manually.
echo.Open a command prompt as admin and paste
echo."DISM /Online /Cleanup-Image /RestoreHealth"
::echo.
::echo.This will ask you to run DISM as an administrator.
::echo.
::echo.When you are ready, press any key.
::pause
::powershell "start DISM /Online /Cleanup-Image /RestoreHealth -v runAs"
echo.To ensure that everything is fixed, I recommend that you run this up until
echo.SFC says that did not find any bad files (or until 5 times if it doesn't stop finding them).
echo.However this is completely optional.
pause
goto :MainMenu

:Help
@echo off
cls
echo.
title What do you need help with?
echo.Hello!  Select an option to get help for that topic.
echo.
echo.  1: Back
echo.  2: Tutorial (unfinished)
echo.  3: Links
echo.
echo.Which do you want?
set /p HelpChoice=
if not '%HelpChoice%'=='' set HelpChoice=%HelpChoice:~0,1%
if '%HelpChoice%'=='1' goto :ClearAndMenu
if '%HelpChoice%'=='2' goto :wantsTutorial
if '%HelpChoice%'=='3' goto :Links
cls
echo."%HelpChoice%" is not a valid option, please try again.
goto :Help

:Links
@echo off
cls
echo.
title Links
echo.  1: Back
echo.  2: GitHub repository for this project
echo.  3: Developer's website (not garrunteed to be up)
echo.  4: Developer's YouTube Channel (subscribe! :D)
echo.  5: Developer's GitHub user
echo.  6: Developer's Discord Server
echo.  7: Developer's Twitch Channel
echo.Which do you want?
set /p LinkChoice=
if not '%LinkChoice%'=='' set LinkChoice=%LinkChoice:~0,1%
if '%LinkChoice%'=='1' goto :Help
if '%LinkChoice%'=='2' start "" https://github.com/sanikdah/Ease-of-use-CMD-launch-script/tree/main/
if '%LinkChoice%'=='3' start "" https://www.techflash.ga/
if '%LinkChoice%'=='4' start "" https://youtube.com/channel/UCZNRlvLcjqN8nw6YO73IPOg/
if '%LinkChoice%'=='5' start "" https://github.com/sanikdah/
if '%LinkChoice%'=='6' start "" https://discord.com/invite/FnseMDFBH6
if '%LinkChoice%'=='7' start "" https://twitch.tv/sanikdahh
cls
echo "%LinkChoice%" is not a valid option, please try again.
echo.
goto :Links

:CurlIPme
@echo off
title Please wait....
echo Getting your IP....
curl ip.me -s > TempIP.txt
set /p IP= < TempIP.txt
cls
echo Your public IP is %IP%!
set %IP%='%blank%'
del TempIP.txt
goto :MainMenu

:CheckNetworkStatistics
@echo off
title Checking network statistics...
start %windir%\system32\netstat
echo.Press any key to go back to the menu.
pause
goto :MainMenu


:GoToRegularCMD
@echo off
title Command Prompt
goto :leave
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
echo.%mydate%:%mytime%		ERROR  End of GoToRegularCMD triggered!!! > Log.txt

:PingGoogle
@echo off
title Pinging Google......
ping google.com -n 1 > PingStats.txt
if %errorlevel%==0 (set InternetState=up) else (set InternetState=down)
cls
echo.
echo.Internet is %InternetState%!
del /f PingStats.txt
goto :MainMenu
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
echo.%mydate%:%mytime%		ERROR  End of PingGoogle triggered!!! > Log.txt


::Debug options, to be accessible by those who know exactly what they are doing
:debug
@echo off
cls
title WARNING
echo.====WARNING========WARNING=======WARNING=====
echo.====WARNING========WARNING=======WARNING=====
echo.====WARNING========WARNING=======WARNING=====
echo.THESE ARE DEBUG OPTIONS AND **CAN** BREAK THE PROGRAM!!
echo.ARE YOU **101% POSITIVE** THAT YOU NEED THESE?
echo.
echo.Do you understand this aggreement? The creator takes no responsibilty in what can happen if I, the user, breaks part of the program, by using explictly stated as options for DEBUGGING purposes.
echo.
set /p isSureOfDebugOptions=
if not '%isSureOfDebugOptions%'=='' set isSureOfDebugOptions=%isSureOfDebugOptions:~0,1%
if '%isSureOfDebugOptions%'=='y' goto :realDebug
if '%isSureOfDebugOptions%'=='Y' goto :realDebug
if '%isSureOfDebugOptions%'=='n' goto :noDebug
if '%isSureOfDebugOptions%'=='N' goto :noDebug
cls
echo."%isSureOfDebugOptions%" is not a valid option, please try again.
goto :noDebug


:noDebug
@echo off
cls
echo No debug if you don't accept the aggreement.
goto :MainMenu

:realDebug
@echo off
echo.Severly untested options.
echo.   1. Go back to the main menu.
echo.	2. Jump directly to any batch label in the script. (Some maybe be intentionally hidden due to being unfinished!)
echo.   3. The super dangerous stuff (potentially script or **ENTIRE PC BREAKING**)
echo.Which do you want to do?
set /p debugChoice=
if not '%debugChoice%'=='' set debugChoice=%debugChoice:~0,1%
if '%debugChoice%'=='1' goto :MainMenu
if '%debugChoice%'=='2' goto :gotoAnyBatchLabel
if '%debugChoice%'=='3' goto :DangerousDebug
cls
echo."%debugChoice%" is not a valid option, please try again.
goto :realDebug


:: Settings menu
:Settings
@echo off
cls
echo.Welcome to the settings menu!
echo.Here you can modify some settings!
echo.
echo.1: Go back to the main menu.
echo.2: Modify the default color when you start the script.
echo.3: Launch options (load when you start CMD, start when you run a command, or nothing.)
set /p SettingsChoice=
if not '%SetttingsChoice%'=='' set SettingsChoice=%SettingsChoice:~0,1%
if '%SettingsChoice%'=='1' goto :MainMenu
if '%SettingsChoice%'=='2' goto :color
if '%SettingsChoice%'=='3' (
	cls
	goto :FirstTimeUser1.5
)

:: A label used for when I wanted to add an option but it isn't implemented yet or is in a state where it can't be used.  Or if I just haven't though of anything to put in that slot yet.
:Nothing
@echo off
echo Nothing here yet!  There might be soon O_O
echo. Going back to the main menu in 5 seconds.
timeout 5
goto :MainMenu

:: A basic section of code for setting the default color of the shell.
:color
@echo off
cls
echo.Welcome to the color selection menu! (kinda janky but it works)
echo.Please enter a Command Prompt-format color code.
set /p ColorCode=
echo.Great!  Does this look good?
color %ColorCode%
set /p YesNoColor=
if not '%YesNoColor%'=='' set choice=%YesNoColor:~0,1%
if '%YesNoColor%'=='y' goto :SetColor
if '%YesNoColor%'=='Y' goto :SetColor
if '%YesNoColor%'=='n' goto :color
if '%YesNoColor%'=='N' goto :color
ECHO. "%YesNoColor%" is not a valid option, please try again.
goto :color

:: Some code to actually set the color code.
:SetColor
@echo off
echo.Great!  Would you like to save the color code
echo.so that it is applied every time you start the
echo.script?
set /p YesNoColor2=
if not '%YesNoColor2%'=='' set choice=%YesNoColor2:~0,1%
if '%YesNoColor2%'=='y' goto :SetColor2
if '%YesNoColor2%'=='Y' goto :SetColor2
if '%YesNoColor2%'=='n' goto :MainMenu
if '%YesNoColor2%'=='N' goto :MainMenu
ECHO. "%YesNoColor2%" is not a valid option, please try again.
goto :SetColor

:: Some code to for real this time set the color code.
:SetColor2
@echo off
echo %ColorCode% > Color.txt
echo. The file now needs some modification, I will open your default text editor and show you what you have to do.
echo. (Note that this process is temporary and only needed to fix a strange bug that occurs.)
start "" "%appdata%\Sanikdah Software\Ease of Use Command Prompt Auto Run Script\Color.txt"
echo. Now, click at the bottom area of the window, your text caret\cursor should be at the line below your color code.
echo. Then press Backspace 2 times, to delete that extra line, and the extra space after the color code.
echo. Now, save and exit the file.  And press any key to resume the program with your new color code!
pause
goto :Init


:: Simplest one of them all, exits the shell
:exit
exit
echo


:: End of the file, used to end the script (like to go to the normal shell)
:leave
@echo off
echo.THIS IS BROKEN, YOU **LIKELY** DO NOT HAVE ERRORS, AND THIS ONLY SENDS THE FIRST LINE OF THE LOG!!!!
findstr /c:"ERROR" log.txt > isHaveErrors.txt
set /p isHaveError= < isHaveErrors.txt
::del /f isHaveErrors.txt
if not "%isHaveError%"=="" (
	copy Log.txt Log.send > nul
	echo.Errors were found in your log file, do you want
	echo.to send the log file to the developer to diagnose the issue?
	set /p sendLogChoice=
	if not '%sendLogChoice%'=='' set sendLogChoice=%sendLogChoice:~0,1%
	if '%sendLogChoice%'=='y' goto :SubmitLogFile
	if '%sendLogChoice%'=='Y' goto :SubmitLogFile
	if '%sendLogChoice%'=='n' goto :realLeave
	if '%sendLogChoice%'=='N' goto :realLeave
	ECHO. "%sendLogChoice%" is not a valid option, please try again.
	goto :leave
)
else (
	goto :realLeave
)
:SubmitLogFile
@echo off
set /p Log= < Log.send
echo.%Log%
echo.Email that I can reach you at if required? OPTIONAL
set /p emailForLog=
echo.Sending the log...
curl -X POST -d program=AutoRunCMD -d email=%emailForLog% -d "logData=%Log%" https://techflash.ga/saveLogsFromPrograms 
echo.Done!  Please wait for the developer to review your log, and reach out to you via email if necessary.
echo.No clue if it actually sent though, if I don't respond within 48 hours, please reach out and ask if I recieved it or not.
echo.If you need to reach me, ask on my Discord server, or email me.
:realLeave
@echo on
