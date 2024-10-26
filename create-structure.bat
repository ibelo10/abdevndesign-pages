@echo off
echo Creating project structure...

:: Create main directories
mkdir components
mkdir components\nav
mkdir components\hero
mkdir components\portfolio
mkdir assets
mkdir assets\css
mkdir assets\js
mkdir assets\images
mkdir includes

:: Create component files
echo. > index.html
echo. > components\head.html
echo. > components\nav\nav.html
echo. > components\nav\services-menu.html
echo. > components\nav\portfolio-menu.html
echo. > components\nav\about-menu.html
echo. > components\nav\contact-menu.html
echo. > components\hero\hero.html
echo. > components\hero\scrolling-text.html
echo. > components\portfolio\portfolio.html
echo. > components\portfolio\filters.html
echo. > components\portfolio\project-cards.html
echo. > components\portfolio\modal.html

:: Create asset files
echo. > assets\css\styles.css
echo. > assets\css\nav.css
echo. > assets\css\portfolio.css
echo. > assets\js\main.js
echo. > assets\js\portfolio.js

:: Create includes
echo. > includes\scripts.html

echo Project structure created successfully!
pause