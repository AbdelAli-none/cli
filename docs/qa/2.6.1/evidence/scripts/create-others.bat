@echo off
set "CLI=E:\P\P\JS learn\Open Source\cli"
set "LOGS=%CLI%\docs\qa\2.6.1\evidence\logs"
cd /d E:\qa-work
for %%F in (nextjs vue-vite nuxt sveltekit) do call :run %%F
goto :eof

:run
echo ===== %1 =====
echo START %date% %time%
node "%CLI%\bin\index.mjs" %1-noinstall --framework %1 --yes --package-manager npm --no-install --no-start > "%LOGS%\create-%1-noinstall.stdout.log" 2> "%LOGS%\create-%1-noinstall.stderr.log"
echo EXIT %errorlevel%
echo END %date% %time%
echo --- top-level ---
dir /b %1-noinstall
echo --- config ---
findstr /i "framework apiClient serverState clientState forms" %1-noinstall\fsd.config.json
echo --- src ---
if exist %1-noinstall\src dir /b %1-noinstall\src
echo --- app ---
if exist %1-noinstall\app dir /b %1-noinstall\app
exit /b