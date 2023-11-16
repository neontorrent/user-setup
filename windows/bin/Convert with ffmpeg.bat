@echo off
set /p "ext=Please provide the new file extension:"

setlocal enableDelayedExpansion
for %%f in (%*) do (
    echo Processing %%f
    set cmd=${HOME}/bin/batch-convert-with-ffmpeg.sh %ext% '$^(wslpath "%%~f"^)'
    wsl.exe bash -c "!cmd!"
)
endlocal
echo Completed!
pause
