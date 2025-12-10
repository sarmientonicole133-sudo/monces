# Deployment Instructions

This document provides instructions on how to deploy your Laravel e-commerce project to GitHub and Railway.

## Prerequisites

Before running the deployment scripts, you need to install the following tools:

1. **Git** - Version control system
2. **GitHub CLI** (optional but recommended) - Command-line tool for GitHub
3. **Railway CLI** (optional) - Command-line tool for Railway

## Installation Steps

### 1. Install Git

1. Download Git for Windows: https://git-scm.com/download/win
2. Run the installer and follow the installation wizard
3. During installation, select these options:
   - Add Git to PATH
   - Choose default editor (Vim or Nano)
   - Choose default branch name as "main"

### 2. Install GitHub CLI (Optional)

1. Download GitHub CLI for Windows: https://cli.github.com/
2. Run the installer and follow the installation wizard

### 3. Install Railway CLI (Optional)

1. Visit https://railway.app/cli
2. Follow the installation instructions for Windows

## Deployment Scripts

This project includes three PowerShell deployment scripts:

1. `deploy-github.ps1` - Deploys only to GitHub
2. `deploy-railway.ps1` - Deploys only to Railway
3. `deploy-all.ps1` - Deploys to both GitHub and Railway

## Configuration Files for Railway

This project now includes configuration files for Railway deployment:

1. `railway.json` - Railway configuration file
2. `Dockerfile` - Docker configuration for containerized deployment
3. `.docker/nginx.conf` - Nginx web server configuration
4. `.docker/start-container` - Container startup script

These files will help Railway automatically configure your Laravel application.

## Running the Deployment Scripts

### Method 1: Using PowerShell (Recommended)

1. Open PowerShell as Administrator
2. Navigate to your project directory:
   ```powershell
   cd "C:\Users\NICOLE\Downloads\SIA - E-COMMERCE\SIA - E-COMMERCE\myproject"
   ```

3. Run one of the deployment scripts:
   ```powershell
   # For GitHub deployment only
   .\deploy-github.ps1
   
   # For Railway deployment only
   .\deploy-railway.ps1
   
   # For both GitHub and Railway
   .\deploy-all.ps1
   ```

### Method 2: Double-click (Limited functionality)

Some scripts may require PowerShell execution policy changes:

1. Open PowerShell as Administrator
2. Run:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
3. Press 'Y' to confirm

## Railway Deployment Process

### Option 1: Using Railway CLI (After Installation)

1. Install the Railway CLI from https://railway.app/cli
2. Login to Railway:
   ```bash
   railway login
   ```
3. Initialize and deploy:
   ```bash
   railway init
   railway up
   ```

### Option 2: Connect Railway to GitHub (Recommended)

1. First deploy your project to GitHub using the GitHub deployment script
2. Go to https://railway.app and create an account or login
3. Click "New Project" and select "Deploy from GitHub repo"
4. Select your repository (sarmientonicole133-sudo/123)
5. Railway will automatically detect the Laravel project and deploy it

## Troubleshooting

### Common Issues

1. **"git is not recognized" error**
   - Solution: Git is not installed or not added to PATH. Reinstall Git and ensure "Add Git to PATH" option is selected.

2. **Permission denied errors**
   - Solution: Run PowerShell as Administrator

3. **GitHub authentication issues**
   - Solution: Use `gh auth login` to authenticate with GitHub

4. **Railway CLI not found**
   - Solution: Install Railway CLI from https://railway.app/cli

### Manual Deployment Steps

If the scripts don't work, you can manually deploy:

#### GitHub Manual Deployment:
1. Initialize Git repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. Create a new repository on GitHub (https://github.com/new)
   - Repository name: 123
   - Visibility: Public

3. Push to GitHub:
   ```bash
   git branch -M main
   git remote add origin https://github.com/sarmientonicole133-sudo/123.git
   git push -u origin main
   ```

#### Railway Manual Deployment:
1. Install Railway CLI
2. Login to Railway:
   ```bash
   railway login
   ```
3. Initialize and deploy:
   ```bash
   railway init
   railway up
   ```

## Support

For additional help, contact:
- GitHub Support: https://support.github.com/
- Railway Support: https://docs.railway.app/

## Notes

- Your GitHub username is: `sarmientonicole133-sudo`
- Your GitHub repository name is: `123`
- Make sure these are correct before deployment