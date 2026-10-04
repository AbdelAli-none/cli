@echo off
set "CLI=E:\P\P\JS learn\Open Source\cli"
set "LOGS=%CLI%\docs\qa\2.6.1\evidence\logs"
for %%P in (rv-noinstall nextjs-noinstall vue-vite-noinstall nuxt-noinstall sveltekit-noinstall) do call :proj %%P
goto :eof

:proj
echo ===== %1 =====
cd /d E:\qa-work\%1
call :gen %1 feature profile
call :gen %1 entity user
call :gen %1 widget header
call :gen %1 page account
call :gen %1 feature auth
echo --- new files (filtered) ---
git status --short -uall | findstr /i "profile user header account auth"
exit /b

:gen
echo --- %2 %3 --- START %time%
node "%CLI%\bin\index.mjs" --generate %2 %3 > "%LOGS%\gen-%1-%2-%3.stdout.log" 2> "%LOGS%\gen-%1-%2-%3.stderr.log"
echo EXIT %errorlevel%
exit /b