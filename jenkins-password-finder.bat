@echo off
echo ========================================
echo Jenkins Initial Admin Password Finder
echo ========================================
echo.

REM Try common Jenkins installation paths
set PASSWORD_FILE=

REM Windows default path
if exist "C:\Program Files\Jenkins\secrets\initialAdminPassword" (
    set PASSWORD_FILE=C:\Program Files\Jenkins\secrets\initialAdminPassword
    goto :found
)

REM Alternative path
if exist "C:\Program Files (x86)\Jenkins\secrets\initialAdminPassword" (
    set PASSWORD_FILE=C:\Program Files (x86)\Jenkins\secrets\initialAdminPassword
    goto :found
)

REM User directory
if exist "%USERPROFILE%\.jenkins\secrets\initialAdminPassword" (
    set PASSWORD_FILE=%USERPROFILE%\.jenkins\secrets\initialAdminPassword
    goto :found
)

REM Docker installation
if exist "%USERPROFILE%\jenkins_home\secrets\initialAdminPassword" (
    set PASSWORD_FILE=%USERPROFILE%\jenkins_home\secrets\initialAdminPassword
    goto :found
)

echo ❌ Password file not found in common locations.
echo.
echo Please check these locations manually:
echo 1. C:\Program Files\Jenkins\secrets\initialAdminPassword
echo 2. C:\Program Files (x86)\Jenkins\secrets\initialAdminPassword
echo 3. %USERPROFILE%\.jenkins\secrets\initialAdminPassword
echo.
echo Or check Jenkins console output for the password location.
goto :end

:found
echo ✅ Found password file!
echo Location: %PASSWORD_FILE%
echo.
echo Your Jenkins initial admin password is:
echo ========================================
type "%PASSWORD_FILE%"
echo ========================================
echo.
echo Copy this password and paste it in Jenkins login page.
echo.

:end
pause

