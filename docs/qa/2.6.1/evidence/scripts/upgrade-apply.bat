@echo off
set "CLI=E:\P\P\JS learn\Open Source\cli"
set "LOGS=%CLI%\docs\qa\2.6.1\evidence\logs"
cd /d E:\qa-work\rv-legacy
echo START %date% %time%
node "%CLI%\bin\index.mjs" upgrade --yes --no-install --allow-dirty > "%LOGS%\upgrade-legacysim-apply.stdout.log" 2> "%LOGS%\upgrade-legacysim-apply.stderr.log"
echo EXIT upgrade --yes %errorlevel%
echo END %date% %time%
node "%CLI%\bin\index.mjs" upgrade --check > "%LOGS%\upgrade-legacysim-recheck.stdout.log" 2> "%LOGS%\upgrade-legacysim-recheck.stderr.log"
echo EXIT upgrade --check after apply %errorlevel%
echo --- apply stdout, last 15 lines ---
powershell -NoProfile -Command "Get-Content '%LOGS%\upgrade-legacysim-apply.stdout.log' -Tail 15"
echo --- apply stderr ---
type "%LOGS%\upgrade-legacysim-apply.stderr.log"
echo --- .fsd after apply ---
dir /b .fsd
echo --- recheck stdout, first 8 lines ---
powershell -NoProfile -Command "Get-Content '%LOGS%\upgrade-legacysim-recheck.stdout.log' -TotalCount 8"