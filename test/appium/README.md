# Appium Tests for Native Demo App

This directory contains Appium-based tests for the Native Demo App Automation project.

## Setup

1. Install dependencies:
```bash
npm install
```

2. Install Appium:
```bash
npm install -g appium
appium driver install uiautomator2
```

3. Start Appium server:
```bash
appium
```

4. Connect device/emulator:
```bash
adb devices
```

## Running Tests

```bash
# Run all tests
npm test

# Run swipe tests only
npm run test:swipe

# Run drag tests only
npm run test:drag
```

## Configuration

Update `wdio.conf.js` with your device details:
- `deviceName`
- `udid`
- `appPackage`
- `appActivity`

