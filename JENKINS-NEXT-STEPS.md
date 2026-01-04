# Jenkins Next Steps: What to Do Now

## Current Status

✅ **Completed:**
- Jenkinsfile created
- Setup guides created
- Pipeline structure defined

⏳ **To Do:**
- Update Jenkinsfile with correct paths
- Create Jenkins job
- Configure email notifications
- Test the pipeline
- Set up reports

---

## Step 1: Update Jenkinsfile Paths

### Current Placeholders (Need Updating):

```groovy
FLUTTER_HOME = '/path/to/flutter'  // ❌ Update this
ANDROID_HOME = '/path/to/android-sdk'  // ❌ Update this
APPIUM_HOME = '/path/to/appium'  // ❌ Update this
DEVICE_UDID = 'emulator-5554'  // ✅ Usually correct
```

### Windows Paths (Update These):

```groovy
FLUTTER_HOME = 'C:\\Users\\vend.it\\develop\\flutter'
ANDROID_HOME = 'C:\\Users\\vend.it\\AppData\\Local\\Android\\Sdk'
APPIUM_HOME = 'C:\\Users\\vend.it\\AppData\\Roaming\\npm'  // or where Appium is installed
DEVICE_UDID = 'emulator-5554'
```

---

## Step 2: Create Jenkins Job

### Option A: Using Jenkinsfile (Pipeline Job)

1. **Open Jenkins Dashboard**
2. **Click "New Item"**
3. **Enter job name:** `native_demo_app_automation`
4. **Select:** "Pipeline"
5. **Click OK**

### Configure Pipeline:

1. **Pipeline Definition:**
   - Select: **Pipeline script from SCM**
   - SCM: **Git**
   - Repository URL: Your Git repo URL (or use local path)
   - Branch: `*/main` or `*/master`
   - Script Path: `Jenkinsfile`

2. **Build Triggers:**
   - ✅ **Poll SCM** (optional): `H/15 * * * *` (every 15 minutes)
   - ✅ **Build periodically**: `H 2 * * *` (daily at 2 AM)

3. **Save**

### Option B: Manual Job (Freestyle)

1. **New Item → Freestyle Project**
2. **Configure:**
   - Source Code Management: Git
   - Build Steps: Execute shell/Windows batch
   - Post-build Actions: Archive artifacts, Email notifications

---

## Step 3: Configure Email Notifications

### Install Email Extension Plugin:

1. **Manage Jenkins → Plugins**
2. **Search:** "Email Extension Plugin"
3. **Install** and restart Jenkins

### Configure SMTP:

1. **Manage Jenkins → Configure System**
2. **Extended E-mail Notification:**
   - SMTP server: `smtp.gmail.com` (or your SMTP)
   - SMTP Port: `587`
   - ✅ Use SSL
   - User Name: `your-email@gmail.com`
   - Password: Your app password
   - Default user e-mail suffix: `@venturedive.com`

3. **Test Email:**
   - Click "Test configuration"
   - Enter test email
   - Click "Test"

### Update Jenkinsfile Email:

In the Jenkinsfile, update the email address:

```groovy
to: "aroma.gul@venturedive.com"  // Update this
```

---

## Step 4: Configure Test Reports

### Install Required Plugins:

1. **JUnit Plugin** - For test results
2. **HTML Publisher Plugin** - For HTML reports

### Update Jenkinsfile:

The Jenkinsfile already includes report publishing. Make sure these plugins are installed.

---

## Step 5: First Build

### Before Running:

1. **Update paths in Jenkinsfile** (Step 1)
2. **Ensure emulator is running** or configure to start emulator
3. **Check Git repository** is accessible

### Run First Build:

1. **Click "Build Now"** on your job
2. **Monitor console output**
3. **Check for errors**

### Common Issues:

- **Path not found:** Update FLUTTER_HOME, ANDROID_HOME
- **Device not found:** Start emulator or update DEVICE_UDID
- **Appium not found:** Install Appium or update APPIUM_HOME
- **Email not sent:** Configure SMTP settings

---

## Step 6: Verify Everything Works

### Checklist:

- [ ] Job created successfully
- [ ] First build completed
- [ ] APK built successfully
- [ ] Tests executed
- [ ] Reports generated
- [ ] Email notifications sent
- [ ] Artifacts archived

---

## Quick Reference

### Update Jenkinsfile Paths:

```groovy
environment {
    FLUTTER_HOME = 'C:\\Users\\vend.it\\develop\\flutter'
    PATH = "${env.FLUTTER_HOME}\\bin;${env.PATH}"
    ANDROID_HOME = 'C:\\Users\\vend.it\\AppData\\Local\\Android\\Sdk'
    APPIUM_HOME = 'C:\\Users\\vend.it\\AppData\\Roaming\\npm'
    DEVICE_UDID = 'emulator-5554'
    APK_PATH = 'build\\app\\outputs\\flutter-apk\\app-debug.apk'
}
```

### Windows-Specific Commands:

The Jenkinsfile uses Unix commands (`sh`). For Windows, you may need to:
- Use `bat` instead of `sh`
- Update paths to use backslashes
- Use Windows commands for Appium/ADB

---

## Next Actions

1. **Update Jenkinsfile** with correct Windows paths
2. **Create Jenkins job** using the updated Jenkinsfile
3. **Configure email** in Jenkins settings
4. **Run first build** and verify
5. **Check reports** and notifications

---

## Need Help?

- Check `jenkins-complete-setup.md` for detailed setup
- Check `JENKINS-INSTALLATION-GUIDE.md` for Jenkins installation
- Review Jenkinsfile comments for each stage

