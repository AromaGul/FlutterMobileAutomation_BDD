# Jenkins Installation and Setup Guide

## Quick Decision: Do You Need Jenkins Now?

### ✅ Install Jenkins If:
- You want automated builds on schedule
- You need email notifications
- You want CI/CD pipeline
- Multiple team members need access
- You want automated test reports

### ❌ Skip Jenkins For Now If:
- You're just testing locally
- You don't need automation yet
- You want to verify tests work first
- You're the only developer

---

## Option 1: Test Locally First (Recommended)

Before installing Jenkins, verify everything works:

### Windows:
```bash
# Run the local test script
test-locally.bat
```

### Linux/Mac:
```bash
# Run the local test script
chmod +x test-locally.sh
./test-locally.sh
```

This simulates the Jenkins pipeline and verifies:
- ✅ Dependencies install
- ✅ Code builds
- ✅ Device connects
- ✅ APK installs
- ✅ Tests run

---

## Option 2: Install Jenkins

### Windows Installation

#### Method 1: Jenkins Installer (Easiest)
1. Download Jenkins:
   - Go to: https://www.jenkins.io/download/
   - Download: **Windows** installer
   - File: `jenkins.msi`

2. Install:
   - Run `jenkins.msi`
   - Follow installation wizard
   - Jenkins will start automatically

3. Initial Setup:
   - Open browser: `http://localhost:8080`
   - Get initial password from: `C:\Program Files\Jenkins\secrets\initialAdminPassword`
   - Install suggested plugins
   - Create admin user

#### Method 2: Docker (Alternative)
```bash
docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
```

### Linux Installation

#### Ubuntu/Debian:
```bash
# Add Jenkins repository
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt-get update
sudo apt-get install jenkins

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Access Jenkins
# Open: http://localhost:8080
# Password: sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

#### Mac Installation:
```bash
# Using Homebrew
brew install jenkins-lts

# Start Jenkins
brew services start jenkins-lts

# Access Jenkins
# Open: http://localhost:8080
```

---

## Post-Installation Steps

### 1. Access Jenkins
- Open browser: `http://localhost:8080`
- Enter initial admin password
- Install suggested plugins
- Create admin account

### 2. Install Required Plugins
Go to **Manage Jenkins → Plugins → Available**:

- ✅ **Pipeline Plugin** (usually pre-installed)
- ✅ **Git Plugin** (usually pre-installed)
- ✅ **Email Extension Plugin**
- ✅ **HTML Publisher Plugin**
- ✅ **JUnit Plugin**
- ✅ **Timestamper Plugin**
- ✅ **AnsiColor Plugin**

Click **Install without restart** for each.

### 3. Configure Email
1. Go to **Manage Jenkins → Configure System**
2. **Extended E-mail Notification**:
   - SMTP server: `smtp.gmail.com`
   - SMTP Port: `587`
   - ✅ Use SSL
   - ✅ Use TLS
   - User Name: `your-email@gmail.com`
   - Password: `your-app-password`
   - Default Recipients: `team@example.com`

3. **E-mail Notification**:
   - SMTP server: `smtp.gmail.com`
   - ✅ Use SMTP Authentication
   - User Name: `your-email@gmail.com`
   - Password: `your-app-password`

### 4. Configure Global Tools
1. Go to **Manage Jenkins → Global Tool Configuration**
2. **Flutter**:
   - Name: `Flutter`
   - FLUTTER_HOME: `C:\flutter` (Windows) or `/usr/local/flutter` (Linux/Mac)

3. **Android SDK**:
   - ANDROID_HOME: `C:\Android\Sdk` (Windows) or `/usr/local/android-sdk` (Linux/Mac)

### 5. Create Pipeline Job
1. **New Item** → Name: `native-demo-app-automation`
2. Select **Pipeline** → **OK**
3. **Pipeline** section:
   - Definition: **Pipeline script from SCM**
   - SCM: **Git**
   - Repository URL: Your repo URL
   - Script Path: `Jenkinsfile`
4. **Save**

### 6. Update Jenkinsfile
Edit `Jenkinsfile` and update paths:
```groovy
environment {
    FLUTTER_HOME = 'C:\\flutter'  // Your Flutter path
    ANDROID_HOME = 'C:\\Android\\Sdk'  // Your Android SDK path
    DEVICE_UDID = 'emulator-5554'  // Your device UDID
}
```

### 7. Run First Build
1. Click **Build Now**
2. Monitor console output
3. Check email notifications
4. View test reports

---

## Quick Setup Checklist

### Before Jenkins:
- [ ] Flutter installed and working
- [ ] Android SDK installed
- [ ] Device/Emulator connected (`adb devices`)
- [ ] Tests run locally (`flutter test integration_test/`)
- [ ] APK builds successfully (`flutter build apk`)

### Jenkins Setup:
- [ ] Jenkins installed
- [ ] Required plugins installed
- [ ] Email configured
- [ ] Global tools configured
- [ ] Pipeline job created
- [ ] Jenkinsfile paths updated
- [ ] First build successful

---

## Troubleshooting

### Jenkins won't start:
- Check if port 8080 is available
- Check Jenkins logs: `C:\Program Files\Jenkins\jenkins.err.log`
- Try different port: `java -jar jenkins.war --httpPort=8081`

### Can't access Jenkins:
- Check firewall settings
- Verify Jenkins is running: `http://localhost:8080`
- Check Jenkins service status

### Build fails:
- Check console output
- Verify Flutter/Android paths
- Check device connection
- Review error messages

---

## Next Steps After Installation

1. ✅ Test locally first (recommended)
2. ✅ Install Jenkins
3. ✅ Configure plugins and email
4. ✅ Create pipeline job
5. ✅ Update Jenkinsfile paths
6. ✅ Run first build
7. ✅ Verify email notifications
8. ✅ Check test reports

---

## Recommendation

**Start with local testing:**
1. Run `test-locally.bat` (Windows) or `test-locally.sh` (Linux/Mac)
2. Verify everything works
3. Then install Jenkins for automation

This way you know your tests work before setting up CI/CD!

