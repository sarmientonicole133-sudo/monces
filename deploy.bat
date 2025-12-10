@echo off
TITLE Laravel Deployment Tool

echo ==================================================
echo      LARAVEL E-COMMERCE DEPLOYMENT TOOL
echo ==================================================
echo.
echo This tool will help you deploy your Laravel project
echo to GitHub and Railway.
echo.

echo STEP 1: CHECKING PREREQUISITES
echo -------------------------------
git --version >nul 2>&1
if %errorlevel% == 0 (
    echo [OK] Git is installed
) else (
    echo [ERROR] Git is not installed
    echo Please install Git from https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo.
echo STEP 2: PREPARING GIT REPOSITORY
echo ---------------------------------
if not exist ".git" (
    echo Initializing Git repository...
    git init
    git add .
    git commit -m "Initial commit"
    echo [OK] Git repository initialized
) else (
    echo [OK] Git repository already exists
)

echo.
echo STEP 3: DEPLOYING TO GITHUB
echo --------------------------
echo Creating GitHub repository and pushing code...
echo NOTE: You will need to enter your GitHub credentials
echo.

echo Repository will be created at:
echo https://github.com/sarmientonicole133-sudo/123
echo.

set /p choice="Continue with GitHub deployment? (y/n): "
if /i "%choice%"=="y" (
    git branch -M main
    git remote add origin https://github.com/sarmientonicole133-sudo/123.git
    git push -u origin main
    echo.
    echo [SUCCESS] Deployed to GitHub!
) else (
    echo Skipping GitHub deployment
)

echo.
echo STEP 4: DEPLOYING TO RAILWAY (Optional)
echo ---------------------------------------
echo To deploy to Railway:
echo 1. Install Railway CLI from https://railway.app/cli
echo 2. Run: railway login
echo 3. Run: railway up
echo.

echo.
echo DEPLOYMENT COMPLETE
echo -------------------
echo Your options now:
echo 1. Visit your GitHub repository at:
echo    https://github.com/sarmientonicole133-sudo/123
echo 2. Deploy to Railway by following the instructions above
echo.

pause