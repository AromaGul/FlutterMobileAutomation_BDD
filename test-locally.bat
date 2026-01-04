@echo off
REM Local Test Script for Windows - Simulates Jenkins Pipeline Steps

echo 🧪 Local Jenkins Pipeline Simulation
echo ====================================

REM Step 1: Install Dependencies
echo 📦 Step 1: Installing dependencies...
call flutter pub get
if errorlevel 1 (
    echo ❌ Failed to install dependencies
    exit /b 1
)

REM Step 2: Analyze Code
echo 🔍 Step 2: Analyzing code...
call flutter analyze
if errorlevel 1 (
    echo ⚠️ Code analysis found issues
)

REM Step 3: Build APK
echo 🔨 Step 3: Building APK...
call flutter build apk --debug
if errorlevel 1 (
    echo ❌ Failed to build APK
    exit /b 1
)

REM Step 4: Check Device
echo 📱 Step 4: Checking device connection...
adb devices
for /f "tokens=1" %%i in ('adb devices ^| findstr "device"') do set DEVICE_UDID=%%i
if "%DEVICE_UDID%"=="" (
    echo ⚠️ No device connected. Please connect a device or start an emulator.
    exit /b 1
)

REM Step 5: Install APK
echo 📲 Step 5: Installing APK on device...
set APK_PATH=build\app\outputs\flutter-apk\app-debug.apk
adb -s %DEVICE_UDID% install -r %APK_PATH%
if errorlevel 1 (
    echo ❌ Failed to install APK
    exit /b 1
)

REM Step 6: Run Tests
echo 🧪 Step 6: Running integration tests...
call flutter test integration_test\bdd_app_test.dart --timeout=10m
if errorlevel 1 (
    echo ❌ Tests failed
    exit /b 1
)

call flutter test integration_test\app_test.dart --timeout=10m
if errorlevel 1 (
    echo ❌ Tests failed
    exit /b 1
)

echo.
echo ✅ All steps completed successfully!
echo Your setup is ready for Jenkins!

