@echo off
set "CLI=E:\P\P\JS learn\Open Source\cli"
set "LOGS=%CLI%\docs\qa\2.6.1\evidence\logs"
cd /d E:\qa-work
if exist published-test rmdir /S /Q published-test
mkdir published-test
cd /d E:\qa-work\published-test
echo START %date% %time%
call npm view create-fsd-architecture version dist-tags.latest dist.shasum dist.integrity time.modified > "%LOGS%\published-npm-view.stdout.log" 2> "%LOGS%\published-npm-view.stderr.log"
echo EXIT npm view %errorlevel%
type "%LOGS%\published-npm-view.stdout.log"
type "%LOGS%\published-npm-view.stderr.log"
call npm init -y > nul
call npm install create-fsd-architecture@2.6.1 > "%LOGS%\published-npm-install.stdout.log" 2> "%LOGS%\published-npm-install.stderr.log"
echo EXIT npm install published %errorlevel%
node node_modules\create-fsd-architecture\bin\index.mjs --version > "%LOGS%\published-version.stdout.log" 2> "%LOGS%\published-version.stderr.log"
echo EXIT --version %errorlevel%
type "%LOGS%\published-version.stdout.log"
node node_modules\create-fsd-architecture\bin\index.mjs published-rv --framework react-vite --yes --package-manager npm --no-install --no-start > "%LOGS%\published-create-react-vite.stdout.log" 2> "%LOGS%\published-create-react-vite.stderr.log"
echo EXIT create %errorlevel%
echo END %date% %time%
echo --- published-rv src ---
dir /b published-rv\src
findstr /i "framework" published-rv\fsd.config.json
echo --- stderr of install and create ---
type "%LOGS%\published-npm-install.stderr.log"
type "%LOGS%\published-create-react-vite.stderr.log"