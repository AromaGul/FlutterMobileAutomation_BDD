@echo off
echo ========================================
echo Running Native Demo App BDD Tests
echo ========================================
echo.

echo [1/4] Checking Flutter installation...
flutter --version
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Flutter not found!
    pause
    exit /b 1
)
echo.

echo [2/4] Getting dependencies...
flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to get dependencies!
    pause
    exit /b 1
)
echo.

echo [3/4] Checking for connected devices...
flutter devices
echo.

echo [4/4] Finding Android emulator...
for /f "tokens=2" %%i in ('flutter devices ^| findstr "emulator"') do (
    set EMULATOR_ID=%%i
    echo Found emulator: %%i
    goto :found
)

echo No emulator found!
echo.
echo Starting Pixel_6 emulator...
flutter emulators --launch Pixel_6
echo Waiting 45 seconds for emulator to boot...
timeout /t 45 /nobreak >nul

for /f "tokens=2" %%i in ('flutter devices ^| findstr "emulator"') do (
    set EMULATOR_ID=%%i
    echo Found emulator: %%i
    goto :found
)

echo ERROR: Could not find or start emulator!
echo Please start an emulator manually and run this script again.
pause
exit /b 1

:found
echo.
echo ========================================
echo Running BDD Tests on %EMULATOR_ID%
echo ========================================
echo.
echo This will run:
echo - BDD: Swipe Functionality
echo - BDD: Drag and Drop Functionality
echo.
echo Estimated time: 2-3 minutes
echo.

flutter test integration_test/bdd_app_test.dart -d %EMULATOR_ID% --timeout=10m

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo ✅ All BDD Tests Passed!
    echo ========================================
) else (
    echo.
    echo ========================================
    echo ❌ Some Tests Failed
    echo ========================================
    echo Check the output above for details.
)

echo.
pause

