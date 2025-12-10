# Railway Deployment Script for Laravel Application
# Author: Nicole Sarmiento
# Purpose: Deploy Laravel project to Railway

Write-Host "Starting Railway deployment for Laravel application..." -ForegroundColor Green

# Check if Railway CLI is installed
try {
    $railwayVersion = railway --version
    Write-Host "Railway CLI found: $railwayVersion" -ForegroundColor Green
} catch {
    Write-Host "Railway CLI is not installed. Please install Railway CLI first." -ForegroundColor Red
    Write-Host "Instructions:" -ForegroundColor Yellow
    Write-Host "1. Go to https://railway.app/cli" -ForegroundColor Yellow
    Write-Host "2. Download and install the Railway CLI for Windows" -ForegroundColor Yellow
    Write-Host "3. Run this script again after installation" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Alternatively, you can deploy via GitHub integration:" -ForegroundColor Cyan
    Write-Host "1. First deploy to GitHub using: .\deploy-github.ps1" -ForegroundColor Cyan
    Write-Host "2. Connect Railway to your GitHub repository at https://railway.app/new" -ForegroundColor Cyan
    exit 1
}

# Login to Railway (interactive step)
Write-Host "Please login to Railway:" -ForegroundColor Yellow
railway login

# Initialize Railway project or link existing one
Write-Host "Initializing Railway project..." -ForegroundColor Yellow
railway init

# Set Laravel-specific environment variables
Write-Host "Setting Laravel environment variables..." -ForegroundColor Yellow
railway variables set APP_ENV=production
railway variables set APP_DEBUG=false
railway variables set LOG_CHANNEL=errorlog
railway variables set DB_CONNECTION=sqlite

# Generate and set APP_KEY
Write-Host "Generating and setting APP_KEY..." -ForegroundColor Yellow
$appKey = $(php artisan key:generate --show)
railway variables set APP_KEY=$appKey

# Deploy to Railway
Write-Host "Deploying to Railway..." -ForegroundColor Yellow
railway up

Write-Host "Deployment to Railway completed!" -ForegroundColor Green

# Show deployment URL
try {
    $deploymentUrl = railway url
    if ($deploymentUrl) {
        Write-Host "Your application is available at: $deploymentUrl" -ForegroundColor Blue
    }
} catch {
    Write-Host "Could not retrieve deployment URL. Check your Railway dashboard." -ForegroundColor Yellow
}