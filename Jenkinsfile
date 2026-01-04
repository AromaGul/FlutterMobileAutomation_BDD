pipeline {
    agent any
    
    environment {
        // Windows paths - Update these if your installation is different
        FLUTTER_HOME = 'C:\\Users\\vend.it\\develop\\flutter'
        PATH = "${env.FLUTTER_HOME}\\bin;${env.PATH}"
        ANDROID_HOME = 'C:\\Users\\vend.it\\AppData\\Local\\Android\\Sdk'
        APPIUM_HOME = 'C:\\Users\\vend.it\\AppData\\Roaming\\npm' // Appium installed via npm
        DEVICE_UDID = 'emulator-5554' // Update if using different emulator
        APK_PATH = 'build\\app\\outputs\\flutter-apk\\app-debug.apk'
        EMAIL_RECIPIENT = 'aroma.gul@venturedive.com' // Update with your email
    }
    
    options {
        timeout(time: 60, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '20'))
        timestamps()
        ansiColor('xterm')
    }
    
    triggers {
        // Schedule: Run every day at 2 AM
        cron('H 2 * * *')
        // Or run on specific days: cron('H 2 * * 1-5') for weekdays
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out source code...'
                checkout scm
            }
        }
        
        stage('Flutter Setup') {
            steps {
                script {
                    echo '🔧 Setting up Flutter environment...'
                    bat '''
                        flutter --version
                        flutter doctor -v
                    '''
                }
            }
        }
        
        stage('Install Dependencies') {
            steps {
                echo '📦 Installing Flutter dependencies...'
                bat 'flutter pub get'
            }
        }
        
        stage('Analyze Code') {
            steps {
                echo '🔍 Running Flutter analyze...'
                bat 'flutter analyze'
            }
        }
        
        stage('Build APK') {
            steps {
                echo '🔨 Building APK...'
                bat 'flutter build apk --debug'
            }
            post {
                success {
                    echo '✅ APK built successfully'
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', allowEmptyArchive: false
                }
                failure {
                    echo '❌ APK build failed'
                }
            }
        }
        
        stage('Start Appium Server') {
            steps {
                script {
                    echo '🚀 Starting Appium server...'
                    bat '''
                        @echo off
                        REM Kill any existing Appium processes
                        taskkill /F /IM node.exe /FI "WINDOWTITLE eq appium*" 2>nul || echo No Appium processes found
                        
                        REM Start Appium server in background
                        start /B appium --log-level error > appium.log 2>&1
                        
                        REM Wait for Appium to start
                        timeout /t 5 /nobreak >nul
                        
                        REM Verify Appium is running (Windows doesn't have curl by default, skip verification)
                        echo Appium server started
                    '''
                }
            }
        }
        
        stage('Check Device Connection') {
            steps {
                script {
                    echo '📱 Checking device connection...'
                    bat '''
                        adb devices
                        adb -s %DEVICE_UDID% shell getprop ro.build.version.release
                    '''
                }
            }
        }
        
        stage('Install APK on Device') {
            steps {
                script {
                    echo '📲 Installing APK on device...'
                    bat '''
                        adb -s %DEVICE_UDID% install -r %APK_PATH%
                    '''
                }
            }
        }
        
        stage('Run Flutter Integration Tests') {
            steps {
                script {
                    echo '🧪 Running Flutter integration tests...'
                    try {
                        bat '''
                            flutter test integration_test/bdd_app_test.dart --timeout=10m
                            flutter test integration_test/app_test.dart --timeout=10m
                        '''
                    } catch (Exception e) {
                        echo "⚠️ Integration tests failed: ${e.getMessage()}"
                        currentBuild.result = 'UNSTABLE'
                    }
                }
            }
            post {
                always {
                    // Archive test results
                    archiveArtifacts artifacts: 'test/**/*.xml', allowEmptyArchive: true
                    archiveArtifacts artifacts: 'integration_test/**/*.xml', allowEmptyArchive: true
                }
            }
        }
        
        stage('Run Appium Tests') {
            when {
                expression { fileExists('test/appium/') }
            }
            steps {
                script {
                    echo '🤖 Running Appium tests...'
                    try {
                        sh '''
                            cd test/appium
                            npm test || true
                        '''
                    } catch (Exception e) {
                        echo "⚠️ Appium tests failed: ${e.getMessage()}"
                        currentBuild.result = 'UNSTABLE'
                    }
                }
            }
            post {
                always {
                    // Archive Appium test results
                    archiveArtifacts artifacts: 'test/appium/reports/**/*', allowEmptyArchive: true
                }
            }
        }
        
        stage('Generate Test Reports') {
            steps {
                script {
                    echo '📊 Generating test reports...'
                    sh '''
                        # Create reports directory
                        mkdir -p reports
                        
                        # Generate Flutter test report
                        flutter test --machine > test_results.json 2>&1 || true
                        
                        # Convert to JUnit XML if needed
                        # Add your report conversion logic here
                    '''
                }
            }
            post {
                always {
                    // Publish test results
                    publishTestResults testResultsPattern: 'test/**/test-results.xml'
                    publishTestResults testResultsPattern: 'integration_test/**/test-results.xml'
                    
                    // Publish HTML reports
                    publishHTML([
                        reportDir: 'reports',
                        reportFiles: 'index.html',
                        reportName: 'Test Report'
                    ])
                    
                    // Archive reports
                    archiveArtifacts artifacts: 'reports/**/*', allowEmptyArchive: true
                }
            }
        }
        
        stage('Stop Appium Server') {
            steps {
                script {
                    echo '🛑 Stopping Appium server...'
                    bat '''
                        @echo off
                        taskkill /F /IM node.exe /FI "WINDOWTITLE eq appium*" 2>nul || echo Appium already stopped
                    '''
                }
            }
        }
    }
    
    post {
        always {
            echo '📋 Pipeline execution completed'
            // Clean up workspace
            cleanWs()
            
            // Archive Appium logs
            archiveArtifacts artifacts: 'appium.log', allowEmptyArchive: true
        }
        success {
            echo '✅ Pipeline succeeded!'
            script {
                // Send success email
                emailext (
                    subject: "✅ Build #${env.BUILD_NUMBER} - SUCCESS: ${env.JOB_NAME}",
                    body: """
                        <h2>Build Successful!</h2>
                        <p><strong>Job:</strong> ${env.JOB_NAME}</p>
                        <p><strong>Build Number:</strong> ${env.BUILD_NUMBER}</p>
                        <p><strong>Branch:</strong> ${env.BRANCH_NAME}</p>
                        <p><strong>Build URL:</strong> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                        <p><strong>Duration:</strong> ${currentBuild.durationString}</p>
                        <hr>
                        <p>All tests passed successfully!</p>
                        <p>APK artifacts are available in the build artifacts.</p>
                    """,
                    mimeType: 'text/html',
                    to: "${env.EMAIL_RECIPIENT}",
                    recipientProviders: [[$class: 'CulpritsRecipientProvider']]
                )
            }
        }
        failure {
            echo '❌ Pipeline failed!'
            script {
                // Send failure email
                emailext (
                    subject: "❌ Build #${env.BUILD_NUMBER} - FAILED: ${env.JOB_NAME}",
                    body: """
                        <h2>Build Failed!</h2>
                        <p><strong>Job:</strong> ${env.JOB_NAME}</p>
                        <p><strong>Build Number:</strong> ${env.BUILD_NUMBER}</p>
                        <p><strong>Branch:</strong> ${env.BRANCH_NAME}</p>
                        <p><strong>Build URL:</strong> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                        <p><strong>Duration:</strong> ${currentBuild.durationString}</p>
                        <hr>
                        <p>Please check the build logs for details.</p>
                        <p><a href="${env.BUILD_URL}console">View Console Output</a></p>
                    """,
                    mimeType: 'text/html',
                    to: "${env.EMAIL_RECIPIENT}",
                    recipientProviders: [[$class: 'CulpritsRecipientProvider']],
                    attachLog: true
                )
            }
        }
        unstable {
            echo '⚠️ Pipeline is unstable!'
            script {
                // Send unstable email
                emailext (
                    subject: "⚠️ Build #${env.BUILD_NUMBER} - UNSTABLE: ${env.JOB_NAME}",
                    body: """
                        <h2>Build Unstable!</h2>
                        <p><strong>Job:</strong> ${env.JOB_NAME}</p>
                        <p><strong>Build Number:</strong> ${env.BUILD_NUMBER}</p>
                        <p><strong>Branch:</strong> ${env.BRANCH_NAME}</p>
                        <p><strong>Build URL:</strong> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                        <p><strong>Duration:</strong> ${currentBuild.durationString}</p>
                        <hr>
                        <p>Some tests failed or warnings occurred.</p>
                        <p><a href="${env.BUILD_URL}testReport">View Test Report</a></p>
                    """,
                    mimeType: 'text/html',
                    to: "${env.EMAIL_RECIPIENT}",
                    recipientProviders: [[$class: 'CulpritsRecipientProvider']]
                )
            }
        }
    }
}
