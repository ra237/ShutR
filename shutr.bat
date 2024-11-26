@echo off
cls
setlocal

:: Version: 0.1
:: Date:    25 Nov 2024

:::
:::  .-')     ('-. .-.               .-') _     _  .-')   
::: ( OO ).  ( OO )  /              (  OO) )   ( \( -O )  
:::(_)---\_) ,--. ,--.  ,--. ,--.   /     '._   ,------.  
:::/    _ |  |  | |  |  |  | |  |   |'--...__)  |   /`. ' 
:::\  :` `.  |   .|  |  |  | | .-') '--.  .--'  |  /  | | 
::: '..`''.) |       |  |  |_|( OO )   |  |     |  |_.' | 
:::.-._)   \ |  .-.  |  |  | | `-' /   |  |     |  .  '.' 
:::\       / |  | |  | ('  '-'(_.-'    |  |     |  |\  \  
::: `-----'  `--' `--'   `-----'       `--'     `--' '--'
:::

for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A

:Menu
echo.
echo  _________________________________________
echo ^|                 OPTIONS                 ^|
echo ^|=========================================^|
echo ^| [1] 60min [2] 45min [3] 30min [4] 15min ^|
echo ^|                                         ^|
echo ^| [C] Custom [D] Cancel shutdown [E] Exit ^|
echo ^|_________________________________________^|
echo.

CHOICE /C 1234CDE /N

IF ERRORLEVEL 7 GOTO ExitShutr
IF ERRORLEVEL 6 GOTO CancelShutrDown
IF ERRORLEVEL 5 GOTO CustomShutrDown
IF ERRORLEVEL 4 CALL :ShutrDown 15
IF ERRORLEVEL 3 CALL :ShutrDown 30
IF ERRORLEVEL 2 CALL :ShutrDown 45
IF ERRORLEVEL 1 CALL :ShutrDown 60

:: Performs shutdown with given parameter timer in minutes
:ShutrDown
SET /a timerInMinutes=%~1
SET /a timerInSeconds=timerInMinutes*60
shutdown /s /t %timerInSeconds%
IF %ERRORLEVEL% EQU 0 echo Shutdown scheduled in %timerInMinutes% minutes.
GOTO Menu

:: Takes user input to perform shutdown
:CustomShutrDown
SET /p userTimer=Enter shutdown timer in minutes:
SET /a validate=userTimer
IF %validate% EQU %userTimer% (
    CALL :ShutrDown %userTimer%
) ELSE (
    ECHO Invalid input.
)
GOTO Menu

:: Cancel scheduled shutdown
:CancelShutrDown
shutdown /a
IF %ERRORLEVEL% EQU 0 echo Scheduled shutdown aborted.
GOTO Menu

:: Exit program
:ExitShutr
exit 0