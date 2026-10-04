@echo off
set "CLI=E:\P\P\JS learn\Open Source\cli"
set "LOGS=%CLI%\docs\qa\2.6.1\evidence\logs"
cd /d E:\qa-work
if exist packed-test rmdir /S /Q packed-test
mkdir packed-test
pushd "%CLI%"
call npm pack --pack-destination E:\qa-work\packed-test > "%LOGS%\packed-npm-pack.stdout.log" 2> "%LOGS%\packed-npm-pack.stderr.log"
echo EXIT npm pack %errorlevel%
popd
cd /d E:\qa-work\packed-test
echo --- tarball ---
dir /b *.tgz
certutil -hashfile create-fsd-architecture-2.6.1.tgz SHA256
call npm init -y > nul
call npm install .\create-fsd-architecture-2.6.1.tgz > "%LOGS%\packed-npm-install.stdout.log" 2> "%LOGS%\packed-npm-install.stderr.log"
echo EXIT npm install tarball %errorlevel%
node node_modules\create-fsd-architecture\bin\index.mjs --version > "%LOGS%\packed-version.stdout.log" 2> "%LOGS%\packed-version.stderr.log"
echo EXIT --version %errorlevel%
type "%LOGS%\packed-version.stdout.log"
echo START create %date% %time%
node node_modules\create-fsd-architecture\bin\index.mjs packed-rv --framework react-vite --yes --package-manager npm --no-install --no-start > "%LOGS%\packed-create-react-vite.stdout.log" 2> "%LOGS%\packed-create-react-vite.stderr.log"
echo EXIT create %errorlevel%
echo END create %date% %time%
echo --- packed-rv src ---
dir /b packed-rv\src
findstr /i "framework" packed-rv\fsd.config.json
echo --- stderr of install and create ---
type "%LOGS%\packed-npm-install.stderr.log"
type "%LOGS%\packed-create-react-vite.stderr.log"