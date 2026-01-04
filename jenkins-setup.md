# Jenkins Setup Guide for Native Demo App Automation

## Prerequisites

1. **Jenkins Server** - Installed and running
2. **Flutter SDK** - Installed on Jenkins agent
3. **Android SDK** - Installed and configured
4. **Java JDK** - Required for Android builds

## Jenkins Configuration

### 1. Install Required Jenkins Plugins

Install the following plugins via Jenkins Plugin Manager:

- **Pipeline Plugin** (usually pre-installed)
- **Git Plugin** (usually pre-installed)
- **JUnit Plugin** - For test result reporting
- **HTML Publisher Plugin** - For test reports
- **Email Extension Plugin** - For email notifications (optional)

### 2. Configure Flutter on Jenkins Agent

#### On Linux/Mac:
```bash
# Download Flutter SDK
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.x.x-stable.tar.xz
tar xf flutter_linux_3.x.x-stable.tar.xz

# Add to PATH
export PATH="$PATH:/path/to/flutter/bin"
```

#### On Windows:
```powershell
# Download Flutter SDK
# Extract to C:\flutter
# Add to PATH: C:\flutter\bin
```

### 3. Configure Android SDK

Set environment variables in Jenkins:

- `ANDROID_HOME` = `/path/to/android-sdk` (or `C:\Android\Sdk` on Windows)
- `PATH` should include `${ANDROID_HOME}/tools` and `${ANDROID_HOME}/platform-tools`

### 4. Update Jenkinsfile

Edit the `Jenkinsfile` and update these paths:

```groovy
environment {
    FLUTTER_HOME = '/path/to/flutter' // Update this
    ANDROID_HOME = '/path/to/android-sdk' // Update this
}
```

### 5. Create Jenkins Pipeline Job

1. Go to Jenkins Dashboard
2. Click **New Item**
3. Enter job name: `native-demo-app-automation`
4. Select **Pipeline**
5. Click **OK**

### 6. Configure Pipeline

#### Option A: Pipeline from SCM (Recommended)
1. In **Pipeline** section, select **Pipeline script from SCM**
2. **SCM**: Git
3. **Repository URL**: Your Git repository URL
4. **Credentials**: Add credentials if needed
5. **Branches to build**: `*/main` or `*/master`
6. **Script Path**: `Jenkinsfile`
7. Click **Save**

#### Option B: Pipeline Script (Direct)
1. In **Pipeline** section, select **Pipeline script**
2. Copy the content from `Jenkinsfile`
3. Click **Save**

### 7. Run Pipeline

1. Click **Build Now** on the job
2. Monitor the build progress in **Build History**
3. View console output for detailed logs

## Pipeline Stages Explained

1. **Checkout** - Gets source code from repository
2. **Flutter Setup** - Verifies Flutter installation
3. **Install Dependencies** - Runs `flutter pub get`
4. **Analyze Code** - Runs `flutter analyze` for code quality
5. **Run Unit Tests** - Executes unit tests with coverage
6. **Run Integration Tests** - Runs BDD and integration tests
7. **Build APK (Debug)** - Creates debug APK
8. **Build APK (Release)** - Creates release APK (main branch only)
9. **Build App Bundle** - Creates AAB for Play Store (main branch only)

## Test Results

Test results are automatically archived and can be viewed in:
- **Test Results** section of each build
- **Artifacts** section for APK files

## Troubleshooting

### Flutter not found
- Ensure Flutter is installed on Jenkins agent
- Update `FLUTTER_HOME` in Jenkinsfile
- Verify Flutter is in PATH

### Android SDK issues
- Verify `ANDROID_HOME` is set correctly
- Ensure Android SDK tools are installed
- Check Android licenses: `flutter doctor --android-licenses`

### Build failures
- Check console output for specific errors
- Verify all dependencies are available
- Ensure sufficient disk space

### Test timeouts
- Increase timeout in Jenkinsfile: `timeout(time: 60, unit: 'MINUTES')`
- Check emulator/device availability for integration tests

## Advanced Configuration

### Parallel Test Execution
```groovy
stage('Run Tests') {
    parallel {
        stage('Unit Tests') {
            steps {
                sh 'flutter test'
            }
        }
        stage('Integration Tests') {
            steps {
                sh 'flutter test integration_test/'
            }
        }
    }
}
```

### Email Notifications
```groovy
post {
    failure {
        emailext (
            subject: "Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
            body: "Build failed. Check console: ${env.BUILD_URL}",
            to: "team@example.com"
        )
    }
}
```

### Slack Notifications
Add Slack plugin and configure:
```groovy
post {
    success {
        slackSend(
            channel: '#mobile-dev',
            color: 'good',
            message: "Build ${env.BUILD_NUMBER} succeeded!"
        )
    }
}
```

## CI/CD Best Practices

1. **Use Pipeline from SCM** - Keeps Jenkinsfile in version control
2. **Branch-specific builds** - Only build release on main branch
3. **Archive artifacts** - Keep APKs for testing
4. **Test reporting** - Publish test results for visibility
5. **Notifications** - Alert team on failures
6. **Clean workspace** - Avoid disk space issues

## Next Steps

1. Set up Jenkins server
2. Install required plugins
3. Configure Flutter and Android SDK
4. Update Jenkinsfile paths
5. Create pipeline job
6. Run first build!

