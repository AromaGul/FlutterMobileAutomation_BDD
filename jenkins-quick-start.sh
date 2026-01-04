#!/bin/bash

# Jenkins Quick Start Script for Native Demo App Automation
# This script helps set up the environment for Jenkins builds

echo "🚀 Jenkins Quick Start Setup"
echo "============================"

# Check Flutter
echo "📱 Checking Flutter..."
if command -v flutter &> /dev/null; then
    flutter --version
    flutter doctor -v
else
    echo "❌ Flutter not found. Please install Flutter SDK."
    exit 1
fi

# Check Android SDK
echo "🤖 Checking Android SDK..."
if [ -n "$ANDROID_HOME" ]; then
    echo "✅ ANDROID_HOME: $ANDROID_HOME"
    adb version
else
    echo "⚠️ ANDROID_HOME not set. Please set it in Jenkinsfile."
fi

# Check Appium
echo "🔧 Checking Appium..."
if command -v appium &> /dev/null; then
    appium --version
    echo "✅ Appium is installed"
else
    echo "⚠️ Appium not found. Installing..."
    npm install -g appium
    appium driver install uiautomator2
fi

# Check Node.js
echo "📦 Checking Node.js..."
if command -v node &> /dev/null; then
    node --version
    npm --version
else
    echo "❌ Node.js not found. Please install Node.js."
    exit 1
fi

# Check device connection
echo "📱 Checking device connection..."
if command -v adb &> /dev/null; then
    echo "Connected devices:"
    adb devices
else
    echo "⚠️ ADB not found. Please install Android SDK Platform Tools."
fi

# Check Appium server
echo "🔍 Checking Appium server..."
if curl -f http://localhost:4723/wd/hub/status &> /dev/null; then
    echo "✅ Appium server is running"
else
    echo "⚠️ Appium server is not running. Start it with: appium"
fi

echo ""
echo "✅ Setup check complete!"
echo ""
echo "Next steps:"
echo "1. Update Jenkinsfile with correct paths"
echo "2. Configure email settings in Jenkins"
echo "3. Create pipeline job"
echo "4. Run first build"

