@echo off
set "CLI=E:\P\P\JS learn\Open Source\cli"
set "LOGS=%CLI%\docs\qa\2.6.1\evidence\logs"
for %%P in (rv-noinstall nextjs-noinstall vue-vite-noinstall nuxt-noinstall sveltekit-noinstall) do call :proj %%P
goto :eof

:proj
echo ===== %1 =====
cd /d E:\qa-work\%1
for %%C in (check doctor config) do call :cmd %1 %%C
echo --- check output ---
type "%LOGS%\inspect-%1-check.stdout.log"
echo --- doctor output ---
type "%LOGS%\inspect-%1-doctor.stdout.log"
exit /b

:cmd
node "%CLI%\bin\index.mjs" %2 > "%LOGS%\inspect-%1-%2.stdout.log" 2> "%LOGS%\inspect-%1-%2.stderr.log"
echo EXIT %2 %errorlevel%
exit /b