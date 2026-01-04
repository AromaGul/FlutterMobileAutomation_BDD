# Complete Jenkins Integration Setup Guide

## Overview
This guide will help you set up a complete Jenkins CI/CD pipeline for the Native Demo App Automation project with:
- ✅ Device connection (Android Emulator/Real Device)
- ✅ Appium server integration
- ✅ APK building and installation
- ✅ Automated test execution
- ✅ Scheduled jobs
- ✅ Email notifications
- ✅ Test report generation

---

## Prerequisites

### 1. Software Requirements
- **Jenkins** (2.400+)
- **Flutter SDK** (3.0+)
- **Android SDK** (API 30+)
- **Appium** (2.0+)
- **Node.js** (16+)
- **Java JDK** (11+)
- **ADB** (Android Debug Bridge)

### 2. Jenkins Plugins Required
Install these plugins via **Manage Jenkins → Plugins**:

- **Pipeline Plugin**
- **Git Plugin**
- **Email Extension Plugin**
- **HTML Publisher Plugin**
- **JUnit Plugin**
- **Timestamper Plugin**
- **AnsiColor Plugin**
- **Build Timeout Plugin**

---

## Step 1: Install and Configure Appium

### Install Appium
```bash
# Install Appium via npm
npm install -g appium

# Install Appium Doctor
npm install -g appium-doctor

# Verify installation
appium --version
appium-doctor
```

### Install Appium Drivers
```bash
# Install Android driver
appium driver install uiautomator2

# Install iOS driver (if needed)
appium driver install xcuitest
```

### Verify Appium Setup
```bash
# Start Appium server
appium

# In another terminal, check status
curl http://localhost:4723/wd/hub/status
```

---

## Step 2: Configure Android Device/Emulator

### Option A: Use Physical Device
1. Enable **Developer Options** on Android device
2. Enable **USB Debugging**
3. Connect device via USB
4. Verify connection:
   ```bash
   adb devices
   ```

### Option B: Use Emulator
1. Create Android Virtual Device (AVD):
   ```bash
   # List available system images
   avdmanager list system-images
   
   # Create AVD
   avdmanager create avd -n Pixel_6_API_30 -k "system-images;android-30;google_apis;x86_64"
   ```

2. Start emulator:
   ```bash
   emulator -avd Pixel_6_API_30
   ```

3. Verify connection:
   ```bash
   adb devices
   # Should show: emulator-5554
   ```

### Get Device UDID
```bash
adb devices
# Output: emulator-5554    device
# UDID is: emulator-5554
```

---

## Step 3: Configure Jenkins Global Settings

### 1. Configure Email (SMTP)

Go to **Manage Jenkins → Configure System**:

1. **Extended E-mail Notification** section:
   - **SMTP server**: `smtp.gmail.com` (or your SMTP server)
   - **SMTP Port**: `587`
   - **Use SSL**: ✅ Checked
   - **Use TLS**: ✅ Checked
   - **User Name**: `your-email@gmail.com`
   - **Password**: `your-app-password` (use App Password for Gmail)
   - **Default user e-mail suffix**: `@example.com`
   - **Default Recipients**: `team@example.com`
   - **Reply To**: `your-email@gmail.com`

2. **E-mail Notification** section:
   - **SMTP server**: `smtp.gmail.com`
   - **Default user e-mail suffix**: `@example.com`
   - **Use SMTP Authentication**: ✅ Checked
   - **User Name**: `your-email@gmail.com`
   - **Password**: `your-app-password`

### 2. Configure Global Tools

Go to **Manage Jenkins → Global Tool Configuration**:

1. **Flutter**:
   - **Name**: `Flutter`
   - **FLUTTER_HOME**: `/path/to/flutter` (or `C:\flutter` on Windows)

2. **Android SDK**:
   - **ANDROID_HOME**: `/path/to/android-sdk` (or `C:\Android\Sdk` on Windows)

---

## Step 4: Update Jenkinsfile

Edit the `Jenkinsfile` and update these environment variables:

```groovy
environment {
    FLUTTER_HOME = '/path/to/flutter'  // e.g., /usr/local/flutter
    ANDROID_HOME = '/path/to/android-sdk'  // e.g., /usr/local/android-sdk
    APPIUM_HOME = '/usr/local/bin'  // Appium is usually in PATH
    DEVICE_UDID = 'emulator-5554'  // Your device UDID from 'adb devices'
    APK_PATH = 'build/app/outputs/flutter-apk/app-debug.apk'
}
```

### For Windows Jenkins Agent:
```groovy
environment {
    FLUTTER_HOME = 'C:\\flutter'
    ANDROID_HOME = 'C:\\Android\\Sdk'
    APPIUM_HOME = 'C:\\Users\\YourUser\\AppData\\Roaming\\npm'
    DEVICE_UDID = 'emulator-5554'
    APK_PATH = 'build\\app\\outputs\\flutter-apk\\app-debug.apk'
}
```

---

## Step 5: Create Jenkins Pipeline Job

### 1. Create New Job
1. Go to Jenkins Dashboard
2. Click **New Item**
3. Enter name: `native-demo-app-automation`
4. Select **Pipeline**
5. Click **OK**

### 2. Configure Pipeline
1. **General** section:
   - ✅ **GitHub project** (if using GitHub)
   - ✅ **This project is parameterized** (optional)
   - Add parameter: `DEVICE_UDID` (String, default: `emulator-5554`)

2. **Build Triggers** section:
   - ✅ **Build periodically** (already in Jenkinsfile via cron)
   - ✅ **Poll SCM** (optional): `H/15 * * * *` (every 15 minutes)

3. **Pipeline** section:
   - **Definition**: Pipeline script from SCM
   - **SCM**: Git
   - **Repository URL**: Your repository URL
   - **Credentials**: Add if needed
   - **Branches to build**: `*/main` or `*/master`
   - **Script Path**: `Jenkinsfile`

4. **Post-build Actions**:
   - ✅ **Publish JUnit test result report**
     - Test report XMLs: `test/**/test-results.xml`
   - ✅ **Publish HTML reports**
     - HTML directory to archive: `reports`

### 3. Configure Email Recipients
In the job configuration, add:
- **Editable Email Notification**:
  - **Project Recipient List**: `team@example.com,dev@example.com`
  - **Triggers**: 
    - ✅ **Success**
    - ✅ **Failure**
    - ✅ **Unstable**

---

## Step 6: Schedule Configuration

The Jenkinsfile includes a cron trigger. To modify the schedule:

### Edit in Jenkinsfile:
```groovy
triggers {
    // Run every day at 2 AM
    cron('H 2 * * *')
    
    // Run every weekday at 9 AM
    // cron('H 9 * * 1-5')
    
    // Run every 6 hours
    // cron('H */6 * * *')
    
    // Run every Monday at 8 AM
    // cron('H 8 * * 1')
}
```

### Cron Syntax:
- `H 2 * * *` - Every day at 2 AM (random minute)
- `H 9 * * 1-5` - Weekdays at 9 AM
- `H */6 * * *` - Every 6 hours
- `0 0 * * *` - Every day at midnight

### Or Configure in Jenkins UI:
1. Go to job configuration
2. **Build Triggers** section
3. ✅ **Build periodically**
4. Enter cron expression: `H 2 * * *`

---

## Step 7: Test Report Generation

### Flutter Test Reports
The pipeline automatically:
1. Runs tests with coverage
2. Generates test results
3. Publishes JUnit XML reports
4. Archives HTML reports

### View Reports
After a build:
1. Click on build number
2. Click **Test Result** (if tests ran)
3. View **HTML Report** (if configured)

### Custom Report Generation
Add to Jenkinsfile:
```groovy
stage('Generate Reports') {
    steps {
        sh '''
            # Generate coverage report
            flutter test --coverage
            
            # Generate HTML report
            genhtml coverage/lcov.info -o coverage/html
        '''
    }
    post {
        always {
            publishHTML([
                reportDir: 'coverage/html',
                reportFiles: 'index.html',
                reportName: 'Coverage Report'
            ])
        }
    }
}
```

---

## Step 8: Email Notification Configuration

### Default Recipients
Update in Jenkinsfile:
```groovy
to: "${env.CHANGE_AUTHOR_EMAIL ?: 'team@example.com'}"
```

### Multiple Recipients
```groovy
to: "team@example.com,dev@example.com,qa@example.com"
```

### Email Templates
The Jenkinsfile includes HTML email templates for:
- ✅ **Success** - Green, includes build details
- ❌ **Failure** - Red, includes error details and log attachment
- ⚠️ **Unstable** - Yellow, includes test report link

### Gmail Setup
1. Enable 2-Factor Authentication
2. Generate App Password:
   - Go to Google Account → Security → App passwords
   - Generate password for "Mail"
   - Use this password in Jenkins SMTP config

---

## Step 9: Run First Build

### Manual Build
1. Go to job dashboard
2. Click **Build Now**
3. Monitor progress in **Build History**
4. Click build number to see console output

### Verify
1. ✅ Check console output for errors
2. ✅ Verify APK is built
3. ✅ Check device connection
4. ✅ Verify Appium server starts
5. ✅ Check tests run successfully
6. ✅ Verify email is sent
7. ✅ Check test reports are generated

---

## Step 10: Troubleshooting

### Appium Server Issues
```bash
# Check if Appium is running
curl http://localhost:4723/wd/hub/status

# Check Appium logs
cat appium.log

# Restart Appium
pkill -f appium
appium
```

### Device Connection Issues
```bash
# List devices
adb devices

# Restart ADB
adb kill-server
adb start-server

# Check device UDID
adb devices -l
```

### Email Not Working
1. Check SMTP settings in Jenkins
2. Verify email credentials
3. Check Jenkins logs: `Manage Jenkins → System Log`
4. Test email: `Manage Jenkins → Configure System → Test configuration`

### Build Failures
1. Check console output
2. Verify all paths are correct
3. Check Flutter/Android SDK installation
4. Verify device is connected
5. Check Appium server is running

---

## Advanced Configuration

### Parallel Test Execution
```groovy
stage('Run Tests') {
    parallel {
        stage('BDD Tests') {
            steps {
                sh 'flutter test integration_test/bdd_app_test.dart'
            }
        }
        stage('Integration Tests') {
            steps {
                sh 'flutter test integration_test/app_test.dart'
            }
        }
    }
}
```

### Slack Notifications
Add to Jenkinsfile:
```groovy
post {
    failure {
        slackSend(
            channel: '#mobile-dev',
            color: 'danger',
            message: "Build ${env.BUILD_NUMBER} failed!"
        )
    }
}
```

### Artifact Management
```groovy
post {
    always {
        archiveArtifacts artifacts: 'build/app/outputs/**/*.apk', allowEmptyArchive: false
        archiveArtifacts artifacts: 'reports/**/*', allowEmptyArchive: true
    }
}
```

---

## Summary Checklist

- [ ] Jenkins installed and running
- [ ] All required plugins installed
- [ ] Flutter SDK configured
- [ ] Android SDK configured
- [ ] Appium installed and configured
- [ ] Device/Emulator connected and verified
- [ ] Email (SMTP) configured
- [ ] Jenkinsfile updated with correct paths
- [ ] Pipeline job created
- [ ] Schedule configured
- [ ] Email recipients configured
- [ ] First build successful
- [ ] Email notifications working
- [ ] Test reports generated

---

## Next Steps

1. **Monitor builds** - Check job dashboard regularly
2. **Review reports** - Analyze test results
3. **Optimize schedule** - Adjust cron based on needs
4. **Add more tests** - Expand test coverage
5. **Integrate with Git** - Auto-trigger on commits
6. **Add deployment** - Deploy APK to test distribution

---

## Support

For issues:
1. Check Jenkins console output
2. Review Appium logs
3. Check device connection
4. Verify all configurations
5. Review this guide

Happy Testing! 🚀

