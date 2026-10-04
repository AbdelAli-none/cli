@echo off
set "CLI=E:\P\P\JS learn\Open Source\cli"
set "LOGS=%CLI%\docs\qa\2.6.1\evidence\logs"
cd /d E:\qa-work
if exist rv-legacy rmdir /S /Q rv-legacy
xcopy /E /I /Q /H rv-noinstall rv-legacy > nul
echo --- .fsd contents before delete ---
dir /b /s rv-legacy\.fsd
rmdir /S /Q rv-legacy\.fsd
cd rv-legacy
node "%CLI%\bin\index.mjs" upgrade --check > "%LOGS%\upgrade-legacysim-check.stdout.log" 2> "%LOGS%\upgrade-legacysim-check.stderr.log"
echo EXIT upgrade --check %errorlevel%
node "%CLI%\bin\index.mjs" upgrade --dry-run > "%LOGS%\upgrade-legacysim-dryrun.stdout.log" 2> "%LOGS%\upgrade-legacysim-dryrun.stderr.log"
echo EXIT upgrade --dry-run %errorlevel%
echo --- check output ---
type "%LOGS%\upgrade-legacysim-check.stdout.log"
type "%LOGS%\upgrade-legacysim-check.stderr.log"
echo --- dry-run output, first 30 lines ---
powershell -NoProfile -Command "Get-Content '%LOGS%\upgrade-legacysim-dryrun.stdout.log' -TotalCount 30"
powershell -NoProfile -Command "Get-Content '%LOGS%\upgrade-legacysim-dryrun.stderr.log' -TotalCount 30"