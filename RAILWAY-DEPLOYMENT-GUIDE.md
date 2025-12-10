# Railway Deployment Guide for Laravel Application

This guide explains how to deploy your Laravel e-commerce application to Railway.

## Prerequisites

1. A Railway account (https://railway.app)
2. Git installed on your system
3. Your Laravel project ready for deployment

## Deployment Methods

### Method 1: Deploy from GitHub (Recommended)

This is the easiest method as Railway can automatically detect and configure your Laravel application.

1. **Deploy to GitHub first**:
   ```bash
   # Run the GitHub deployment script we provided
   ./deploy-github.ps1
   ```

2. **Connect Railway to your GitHub repository**:
   - Go to https://railway.app and sign in/up
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your repository: `sarmientonicole133-sudo/123`
   - Click "Deploy"

3. **Railway will automatically**:
   - Detect this is a Laravel application
   - Use PHP buildpack to build the application
   - Run `composer install` automatically
   - Set up the web process

### Method 2: Deploy using Railway CLI

1. **Install Railway CLI**:
   - Visit https://railway.app/cli
   - Download and install for your operating system

2. **Login to Railway**:
   ```bash
   railway login
   ```

3. **Initialize a new Railway project**:
   ```bash
   railway init
   ```

4. **Deploy your application**:
   ```bash
   railway up
   ```

5. **Add environment variables**:
   ```bash
   railway variables set APP_KEY=$(php artisan key:generate --show)
   railway variables set DB_CONNECTION=sqlite
   ```

## Environment Configuration

Railway automatically provides some environment variables:

- `PORT` - The port your application should listen on
- `DATABASE_URL` - If you add a database plugin

You may need to set these additional variables:

```bash
railway variables set APP_ENV=production
railway variables set APP_DEBUG=false
railway variables set LOG_CHANNEL=errorlog
```

## Database Setup

For production, it's recommended to use a proper database:

1. **Add a MySQL database**:
   - In your Railway project, click "New"
   - Select "Database" then "MySQL"

2. **Railway will automatically set DATABASE_URL**

3. **Configure your Laravel app**:
   ```bash
   railway variables set DB_CONNECTION=mysql
   ```

## Custom Domain (Optional)

1. Go to your Railway project
2. Click on your service
3. Go to the "Settings" tab
4. Scroll to "Custom Domains"
5. Add your domain and follow the DNS instructions

## Troubleshooting

### Common Issues

1. **Build failures**:
   - Check that your `composer.json` is valid
   - Ensure all dependencies can be installed

2. **Application not starting**:
   - Check the logs in Railway dashboard
   - Verify environment variables are set correctly

3. **Database connection issues**:
   - Ensure `DATABASE_URL` is being used correctly
   - Check that you've added a database plugin

### Viewing Logs

```bash
railway logs
```

Or view logs in the Railway dashboard.

## Scaling

Railway automatically scales your application based on traffic. You can manually adjust resources:

1. Go to your service in Railway
2. Click "Settings"
3. Adjust "Instance Size" as needed

## Support

- Railway Documentation: https://docs.railway.app/
- Laravel Documentation: https://laravel.com/docs/