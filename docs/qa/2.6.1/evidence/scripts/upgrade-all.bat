@echo off
set "CLI=E:\P\P\JS learn\Open Source\cli"
set "LOGS=%CLI%\docs\qa\2.6.1\evidence\logs"
for %%P in (rv-noinstall nextjs-noinstall vue-vite-noinstall nuxt-noinstall sveltekit-noinstall) do call :proj %%P
goto :eof

:proj
echo ===== %1 =====
cd /d E:\qa-work\%1
node "%CLI%\bin\index.mjs" upgrade --check > "%LOGS%\upgrade-%1-check.stdout.log" 2> "%LOGS%\upgrade-%1-check.stderr.log"
echo EXIT upgrade --check %errorlevel%
node "%CLI%\bin\index.mjs" upgrade --dry-run > "%LOGS%\upgrade-%1-dryrun.stdout.log" 2> "%LOGS%\upgrade-%1-dryrun.stderr.log"
echo EXIT upgrade --dry-run %errorlevel%
echo --- check output ---
type "%LOGS%\upgrade-%1-check.stdout.log"
type "%LOGS%\upgrade-%1-check.stderr.log"
echo --- dry-run output, first 12 lines ---
powershell -NoProfile -Command "Get-Content '%LOGS%\upgrade-%1-dryrun.stdout.log' -TotalCount 12"
powershell -NoProfile -Command "Get-Content '%LOGS%\upgrade-%1-dryrun.stderr.log' -TotalCount 12"
exit /b