# GitHub Deployment Script for Laravel Application
# Author: Nicole Sarmiento
# Purpose: Deploy Laravel project to GitHub

Write-Host "Starting GitHub deployment for Laravel application..." -ForegroundColor Green

# Check if Git is installed
try {
    $gitVersion = git --version
    Write-Host "Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "Git is not installed. Please install Git first." -ForegroundColor Red
    Write-Host "Download from: https://git-scm.com/downloads" -ForegroundColor Yellow
    exit 1
}

# Initialize Git repository if not already done
if (-not (Test-Path .git)) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init
    git add .
    git commit -m "Initial commit - Laravel E-Commerce Application"
} else {
    Write-Host "Git repository already initialized." -ForegroundColor Green
}

# Add GitHub remote (replace with your actual username and repo)
git remote add origin https://github.com/sarmientonicole133-sudo/123.git

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git branch -M main
git push -u origin main

Write-Host "Deployment to GitHub completed!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Visit your repository at: https://github.com/sarmientonicole133-sudo/123" -ForegroundColor Yellow
Write-Host "2. To deploy to Railway, you can either:" -ForegroundColor Yellow
Write-Host "   a) Install Railway CLI and run: .\deploy-railway.ps1" -ForegroundColor Yellow
Write-Host "   b) Go to https://railway.app/new and connect to your GitHub repository" -ForegroundColor Yellow