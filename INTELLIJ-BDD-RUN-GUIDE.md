# How to Run Native Demo App BDD Tests in IntelliJ IDEA

## Prerequisites

1. **IntelliJ IDEA** with Flutter plugin installed
2. **Android Emulator** running (or physical device connected)
3. **Flutter SDK** configured in IntelliJ

---

## Step-by-Step Guide

### Step 1: Open Project in IntelliJ

1. **Open IntelliJ IDEA**
2. **File → Open** (or `Ctrl + O`)
3. **Navigate to:** `C:\Users\vend.it\Desktop\native_demo_app_automation`
4. **Click OK**
5. **Wait for IntelliJ to index** the project (bottom right corner)

---

### Step 2: Configure Flutter SDK (if not already done)

1. **File → Settings** (or `Ctrl + Alt + S`)
2. **Languages & Frameworks → Flutter**
3. **Set Flutter SDK path:** `C:\Users\vend.it\develop\flutter`
4. **Set Dart SDK path:** (usually auto-detected)
5. **Click Apply → OK**

---

### Step 3: Get Dependencies

1. **Open terminal in IntelliJ** (`Alt + F12` or View → Tool Windows → Terminal)
2. **Run:**
   ```bash
   flutter pub get
   ```
3. **Wait for dependencies to install**

---

### Step 4: Start Android Emulator

**Option A: From IntelliJ**
1. **Click the device dropdown** (top toolbar, next to Run button)
2. **Click "Device Manager"** or **"Open Emulator"**
3. **Select an emulator** (e.g., Pixel_6, Pixel_7)
4. **Click the play button** to start it
5. **Wait 30-60 seconds** for emulator to boot

**Option B: From Terminal**
```bash
flutter emulators --launch Pixel_6
```

**Verify emulator is running:**
```bash
flutter devices
```
You should see: `emulator-5554` or similar

---

### Step 5: Select Android Emulator in IntelliJ

**IMPORTANT:** Make sure Android emulator is selected, NOT Windows!

1. **Look at the device dropdown** (top toolbar)
2. **Click the dropdown**
3. **Select your Android emulator** (e.g., `emulator-5554`)
4. **DO NOT select:** `windows` ❌

---

### Step 6: Run BDD Tests

#### Method 1: Run All BDD Tests (Recommended)

1. **Open the test file:**
   - Navigate to: `integration_test/bdd_app_test.dart`
   - Double-click to open

2. **Run all tests:**
   - **Right-click** on the file in Project Explorer
   - Select **"Run 'bdd_app_test.dart'"**
   
   OR
   
   - Click the **green play button** (▶) next to the `main()` function
   - Select **"Run 'bdd_app_test.dart'"**

3. **Wait for tests to complete** (may take 2-5 minutes)

#### Method 2: Run Individual Test Groups

1. **Open:** `integration_test/bdd_app_test.dart`
2. **Find the test group** you want to run:
   - `group('BDD: Swipe Functionality', ...)`
   - `group('BDD: Drag and Drop Functionality', ...)`
3. **Click the green play button** next to the group name
4. **Select "Run 'BDD: Swipe Functionality'"** (or drag test)

#### Method 3: Run Individual Test Scenarios

1. **Open:** `integration_test/bdd_app_test.dart`
2. **Find the specific test:**
   - `testWidgets('Scenario: Swipe left and right...', ...)`
   - `testWidgets('Scenario: Complete the picture...', ...)`
3. **Click the green play button** next to the test
4. **Select "Run 'Scenario: ...'"**

---

### Step 7: View Test Results

After tests complete, you'll see:

1. **Test Results Panel** (bottom of IntelliJ)
   - ✅ Green checkmark = Passed
   - ❌ Red X = Failed
   - ⚠️ Yellow warning = Warning

2. **Console Output** (shows detailed logs)

3. **Test Report:**
   - Click on a test to see details
   - Expand to see step-by-step execution

---

## Alternative: Run from Terminal (If IntelliJ Has Issues)

If IntelliJ's device selection is problematic, use terminal:

1. **Open terminal in IntelliJ** (`Alt + F12`)
2. **Run:**
   ```bash
   flutter test integration_test/bdd_app_test.dart -d emulator-5554
   ```
   (Replace `emulator-5554` with your actual emulator ID)

---

## Troubleshooting

### Problem: "No device selected" or "Windows device selected"

**Solution:**
1. **Click device dropdown** (top toolbar)
2. **Select Android emulator** (`emulator-5554` or similar)
3. **DO NOT select:** `windows`

### Problem: "Symlink support required"

**Solution:**
- Make sure you selected **Android emulator**, NOT Windows
- If still happening, run from terminal:
  ```bash
  flutter test integration_test/bdd_app_test.dart -d emulator-5554
  ```

### Problem: "No emulator found"

**Solution:**
1. **Start an emulator:**
   ```bash
   flutter emulators --launch Pixel_6
   ```
2. **Wait 30-60 seconds** for it to boot
3. **Verify:**
   ```bash
   flutter devices
   ```
4. **Select it in IntelliJ** device dropdown

### Problem: Tests timeout or hang

**Solution:**
1. **Make sure emulator is fully booted** (wait 1-2 minutes after starting)
2. **Check emulator is responsive** (try interacting with it)
3. **Restart emulator** if needed
4. **Run tests again**

### Problem: "Target of URI doesn't exist"

**Solution:**
1. **Run:**
   ```bash
   flutter pub get
   ```
2. **Restart IntelliJ**
3. **File → Invalidate Caches → Restart**

---

## Quick Reference

### Run Commands

**From IntelliJ:**
- Right-click test file → Run
- Click green play button next to test

**From Terminal:**
```bash
# Run all BDD tests
flutter test integration_test/bdd_app_test.dart -d emulator-5554

# Run specific test group (use grep to filter)
flutter test integration_test/bdd_app_test.dart -d emulator-5554 --plain-name "Swipe"
```

### Check Devices
```bash
flutter devices
```

### Start Emulator
```bash
flutter emulators --launch Pixel_6
```

---

## Test Structure

The BDD tests are in: `integration_test/bdd_app_test.dart`

**Test Groups:**
1. **BDD: Swipe Functionality**
   - Scenario: Swipe left and right on the application

2. **BDD: Drag and Drop Functionality**
   - Scenario: Complete the picture by dragging and dropping parts

**Feature Files:**
- `features/swipe_scenario.feature`
- `features/drag_scenario.feature`

---

## Expected Test Duration

- **Swipe Test:** ~30-60 seconds
- **Drag Test:** ~30-60 seconds
- **Total:** ~2-3 minutes

---

## Success Indicators

✅ **All tests pass** - You'll see:
```
00:00 +0: loading...
00:30 +1: BDD: Swipe Functionality Scenario: Swipe left and right...
01:00 +2: BDD: Drag and Drop Functionality Scenario: Complete the picture...
01:30 +2: All tests passed!
```

---

## Summary

1. ✅ Open project in IntelliJ
2. ✅ Get dependencies (`flutter pub get`)
3. ✅ Start Android emulator
4. ✅ Select Android emulator in device dropdown
5. ✅ Run `bdd_app_test.dart`
6. ✅ View results

**Remember:** Always select **Android emulator**, NOT Windows!

---

## Need Help?

If you encounter issues:
1. Check device selection (must be Android emulator)
2. Verify emulator is running (`flutter devices`)
3. Try running from terminal as alternative
4. Check IntelliJ console for error messages

