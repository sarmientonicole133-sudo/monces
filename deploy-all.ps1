# Combined Deployment Script for GitHub and Railway (Laravel Specific)
# Author: Nicole Sarmiento
# Purpose: Deploy Laravel project to both GitHub and Railway

param(
    [Parameter(Mandatory=$false)]
    [string]$GithubUsername = "sarmientonicole133-sudo",
    
    [Parameter(Mandatory=$false)]
    [string]$RepositoryName = "123"
)

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Starting Combined Deployment Process " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Function to check if a command exists
function Test-CommandExists {
    param([string]$command)
    try {
        $exists = Get-Command $command -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Check prerequisites
Write-Host "`n[1/4] Checking Prerequisites..." -ForegroundColor Yellow

# Check Git
if (-not (Test-CommandExists "git")) {
    Write-Host "ERROR: Git is not installed." -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/downloads" -ForegroundColor Yellow
    exit 1
} else {
    $gitVersion = git --version
    Write-Host "✓ Git found: $gitVersion" -ForegroundColor Green
}

# Check GitHub CLI
if (-not (Test-CommandExists "gh")) {
    Write-Host "WARNING: GitHub CLI not found. Will use standard Git commands." -ForegroundColor Yellow
    $ghAvailable = $false
} else {
    $ghVersion = gh --version
    Write-Host "✓ GitHub CLI found: $($ghVersion.Lines[0])" -ForegroundColor Green
    $ghAvailable = $true
}

# Check Railway CLI
if (-not (Test-CommandExists "railway")) {
    Write-Host "WARNING: Railway CLI not found. Skipping Railway deployment." -ForegroundColor Yellow
    Write-Host "You can still deploy to Railway via GitHub integration after GitHub deployment." -ForegroundColor Yellow
    $railwayAvailable = $false
} else {
    $railwayVersion = railway --version
    Write-Host "✓ Railway CLI found: $railwayVersion" -ForegroundColor Green
    $railwayAvailable = $true
}

# Prepare Git repository
Write-Host "`n[2/4] Preparing Git Repository..." -ForegroundColor Yellow

# Initialize Git repository if not already done
if (-not (Test-Path .git)) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init
    # Check if there are files to commit
    $files = Get-ChildItem -Recurse -File | Where-Object { $_.FullName -notlike "*\.git*" }
    if ($files.Count -gt 0) {
        git add .
        git commit -m "Initial commit"
        Write-Host "✓ Created initial commit" -ForegroundColor Green
    } else {
        Write-Host "No files found to commit" -ForegroundColor Yellow
    }
} else {
    Write-Host "✓ Git repository already initialized" -ForegroundColor Green
}

# GitHub Deployment
Write-Host "`n[3/4] Deploying to GitHub..." -ForegroundColor Yellow

$repoUrl = "https://github.com/$GithubUsername/$RepositoryName.git"

# Try to create repository using GitHub CLI if available
if ($ghAvailable) {
    try {
        Write-Host "Attempting to create repository using GitHub CLI..." -ForegroundColor Yellow
        gh repo create "$GithubUsername/$RepositoryName" --public --clone
        Write-Host "✓ Repository created successfully using GitHub CLI" -ForegroundColor Green
    } catch {
        Write-Host "Using existing repository or falling back to Git commands" -ForegroundColor Yellow
    }
}

# Add remote and push
try {
    # Check if remote already exists
    $remotes = git remote
    if ($remotes -notcontains "origin") {
        git remote add origin $repoUrl
        Write-Host "✓ Added remote origin" -ForegroundColor Green
    } else {
        Write-Host "✓ Remote origin already exists" -ForegroundColor Green
    }
    
    # Push to GitHub
    git branch -M main
    git push -u origin main --force
    Write-Host "✓ Pushed code to GitHub repository" -ForegroundColor Green
    
    Write-Host "`nGitHub Deployment Successful!" -ForegroundColor Green
    Write-Host "Repository URL: $repoUrl" -ForegroundColor Blue
} catch {
    Write-Host "ERROR: Failed to deploy to GitHub" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}

# Railway Deployment
Write-Host "`n[4/4] Deploying to Railway..." -ForegroundColor Yellow

if ($railwayAvailable) {
    try {
        # Check if already logged in
        $loginStatus = railway whoami
        if ($null -eq $loginStatus) {
            Write-Host "Please login to Railway:" -ForegroundColor Yellow
            railway login
        } else {
            Write-Host "Already logged in to Railway as: $loginStatus" -ForegroundColor Green
        }
        
        # Initialize Railway project
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
        railway up
        Write-Host "`nRailway Deployment Successful!" -ForegroundColor Green
        
        # Show deployment URL
        $deploymentUrl = railway url
        if ($deploymentUrl) {
            Write-Host "Deployment URL: $deploymentUrl" -ForegroundColor Blue
        }
    } catch {
        Write-Host "ERROR: Failed to deploy to Railway" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
    }
} else {
    Write-Host "`nSkipping Railway deployment (CLI not found)" -ForegroundColor Yellow
    Write-Host "To deploy to Railway:" -ForegroundColor Yellow
    Write-Host "Option 1 - Install Railway CLI:" -ForegroundColor Cyan
    Write-Host "  1. Install Railway CLI from https://railway.app/cli" -ForegroundColor Yellow
    Write-Host "  2. Run railway login" -ForegroundColor Yellow
    Write-Host "  3. Run railway up" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Option 2 - Use GitHub Integration (Recommended):" -ForegroundColor Cyan
    Write-Host "  1. Go to https://railway.app/new" -ForegroundColor Yellow
    Write-Host "  2. Select 'Deploy from GitHub repo'" -ForegroundColor Yellow
    Write-Host "  3. Choose your repository: $GithubUsername/$RepositoryName" -ForegroundColor Yellow
    Write-Host "  4. Railway will automatically deploy your Laravel application" -ForegroundColor Yellow
}

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host " Deployment Process Completed " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan