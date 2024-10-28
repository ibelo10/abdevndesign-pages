@echo off
echo Creating Netlify project structure...

:: Create main directories
mkdir public
mkdir netlify
mkdir netlify\functions
mkdir public\components
mkdir public\components\nav
mkdir public\components\hero
mkdir public\components\portfolio
mkdir public\assets
mkdir public\assets\css
mkdir public\assets\js
mkdir public\assets\images
mkdir public\includes

:: Create Netlify config and function files
echo [build]> netlify.toml
echo   functions = "netlify/functions">> netlify.toml
echo   publish = "public">> netlify.toml
echo.>> netlify.toml
echo [[redirects]]>> netlify.toml
echo   from = "/api/*">> netlify.toml
echo   to = "/.netlify/functions/:splat">> netlify.toml
echo   status = 200>> netlify.toml

:: Create package.json for Netlify functions
echo {> package.json
echo   "name": "ab-dev-design",>> package.json
echo   "version": "1.0.0",>> package.json
echo   "description": "AB Development & Design website",>> package.json
echo   "scripts": {>> package.json
echo     "dev": "netlify dev">> package.json
echo   },>> package.json
echo   "dependencies": {>> package.json
echo     "@netlify/functions": "^2.0.0",>> package.json
echo     "axios": "^1.6.0">> package.json
echo   }>> package.json
echo }>> package.json

:: Create Netlify function file
mkdir netlify\functions\proxy-php
echo const axios = require('axios');> netlify\functions\proxy-php\proxy-php.js
echo.>> netlify\functions\proxy-php\proxy-php.js
echo exports.handler = async (event, context) ^=^> {>> netlify\functions\proxy-php\proxy-php.js
echo   try {>> netlify\functions\proxy-php\proxy-php.js
echo     const { component } = event.queryStringParameters;>> netlify\functions\proxy-php\proxy-php.js
echo     // Add component handling logic here>> netlify\functions\proxy-php\proxy-php.js
echo     return {>> netlify\functions\proxy-php\proxy-php.js
echo       statusCode: 200,>> netlify\functions\proxy-php\proxy-php.js
echo       headers: {>> netlify\functions\proxy-php\proxy-php.js
echo         'Content-Type': 'application/json',>> netlify\functions\proxy-php\proxy-php.js
echo         'Access-Control-Allow-Origin': '*'>> netlify\functions\proxy-php\proxy-php.js
echo       },>> netlify\functions\proxy-php\proxy-php.js
echo       body: JSON.stringify({ message: 'Success' })>> netlify\functions\proxy-php\proxy-php.js
echo     };>> netlify\functions\proxy-php\proxy-php.js
echo   } catch (error) {>> netlify\functions\proxy-php\proxy-php.js
echo     return { statusCode: 500, body: JSON.stringify({ error: 'Server error' }) };>> netlify\functions\proxy-php\proxy-php.js
echo   }>> netlify\functions\proxy-php\proxy-php.js
echo };>> netlify\functions\proxy-php\proxy-php.js

:: Create .gitignore
echo node_modules> .gitignore
echo .env>> .gitignore
echo .netlify>> .gitignore
echo dist>> .gitignore
echo .DS_Store>> .gitignore

:: Create static files
echo. > public\index.html
echo. > public\components\head.html
echo. > public\components\nav\nav.html
echo. > public\components\nav\services-menu.html
echo. > public\components\nav\portfolio-menu.html
echo. > public\components\nav\about-menu.html
echo. > public\components\nav\contact-menu.html
echo. > public\components\hero\hero.html
echo. > public\components\hero\scrolling-text.html
echo. > public\components\portfolio\portfolio.html
echo. > public\components\portfolio\filters.html
echo. > public\components\portfolio\project-cards.html
echo. > public\components\portfolio\modal.html

:: Create asset files
echo. > public\assets\css\styles.css
echo. > public\assets\css\nav.css
echo. > public\assets\css\portfolio.css
echo. > public\assets\js\main.js
echo. > public\assets\js\portfolio.js
echo. > public\assets\js\component-loader.js

:: Create includes
echo. > public\includes\scripts.html

echo Project structure created successfully!
echo.
echo Next steps:
echo 1. Run 'npm install' to install dependencies
echo 2. Install Netlify CLI: npm install -g netlify-cli
echo 3. Run 'netlify login' to authenticate
echo 4. Run 'netlify dev' to start local development server
echo.
pause