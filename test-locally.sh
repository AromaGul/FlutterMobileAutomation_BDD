#!/bin/bash

# Local Test Script - Simulates Jenkins Pipeline Steps
# Run this to verify everything works before setting up Jenkins

echo "🧪 Local Jenkins Pipeline Simulation"
echo "===================================="

# Step 1: Install Dependencies
echo "📦 Step 1: Installing dependencies..."
flutter pub get
if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies"
    exit 1
fi

# Step 2: Analyze Code
echo "🔍 Step 2: Analyzing code..."
flutter analyze
if [ $? -ne 0 ]; then
    echo "⚠️ Code analysis found issues"
fi

# Step 3: Build APK
echo "🔨 Step 3: Building APK..."
flutter build apk --debug
if [ $? -ne 0 ]; then
    echo "❌ Failed to build APK"
    exit 1
fi

# Step 4: Check Device
echo "📱 Step 4: Checking device connection..."
adb devices
DEVICE_COUNT=$(adb devices | grep -v "List" | grep "device" | wc -l)
if [ $DEVICE_COUNT -eq 0 ]; then
    echo "⚠️ No device connected. Please connect a device or start an emulator."
    exit 1
fi

# Step 5: Install APK
echo "📲 Step 5: Installing APK on device..."
DEVICE_UDID=$(adb devices | grep "device" | head -1 | awk '{print $1}')
APK_PATH="build/app/outputs/flutter-apk/app-debug.apk"
adb -s $DEVICE_UDID install -r $APK_PATH
if [ $? -ne 0 ]; then
    echo "❌ Failed to install APK"
    exit 1
fi

# Step 6: Run Tests
echo "🧪 Step 6: Running integration tests..."
flutter test integration_test/bdd_app_test.dart --timeout=10m
if [ $? -ne 0 ]; then
    echo "❌ Tests failed"
    exit 1
fi

flutter test integration_test/app_test.dart --timeout=10m
if [ $? -ne 0 ]; then
    echo "❌ Tests failed"
    exit 1
fi

echo ""
echo "✅ All steps completed successfully!"
echo "Your setup is ready for Jenkins!"

