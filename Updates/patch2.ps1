# Patch 2 script for AB Development & Design website - CSS Modularization
Write-Host "Applying CSS modularization patch..." -ForegroundColor Cyan

# Function to create directory if it doesn't exist
function New-SafeDirectory {
    param([string]$Path)
    
    if (!(Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "Created directory: $Path" -ForegroundColor Green
        return $true
    }
    Write-Host "Directory exists: $Path" -ForegroundColor Yellow
    return $false
}

# Function to create or update file
function Set-SafeFile {
    param(
        [string]$Path,
        [string]$Content,
        [string]$Description,
        [bool]$Overwrite = $false
    )
    
    $exists = Test-Path $Path
    if (!$exists -or $Overwrite) {
        Set-Content -Path $Path -Value $Content -Encoding UTF8
        if ($exists) {
            Write-Host "Updated $Description" -ForegroundColor Blue
        } else {
            Write-Host "Created $Description" -ForegroundColor Green
        }
        return $true
    }
    Write-Host "$Description exists - skipped" -ForegroundColor Yellow
    return $false
}

# Log patch start
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$patchLog = "patch_log.txt"
Add-Content -Path $patchLog -Value "`n[$timestamp] Starting CSS modularization patch..."

# Main styles content
$mainStyles = @"
:root {
  --menu-width: 37.5em;
  --items: 3;
  --item-width: calc(var(--menu-width) / var(--items));
}

body {
  margin: 0;
  padding: 0;
  font-family: "Roboto", sans-serif;
  overflow-x: hidden;
  min-height: 100vh;
}

.full-mountain-image {
  position: relative;
  width: 100%;
  min-height: 100vh;
  background: url('/assets/images/laptopdark.jpg') no-repeat center center;
  background-size: cover;
  background-attachment: fixed;
}

.full-mountain-image::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 1;
}

.full-mountain-image > * {
  position: relative;
  z-index: 2;
}

.Button {
  display: inline-block;
  padding: 1rem 2rem;
  background: linear-gradient(45deg, #64ffda, #48c6ef);
  color: black;
  text-decoration: none;
  border-radius: 30px;
  font-weight: 600;
  transition: all 0.3s ease;
  margin-top: 2rem;
}

.Button:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(100, 255, 218, 0.3);
}

/* Responsive Media Queries */
@media (max-width: 1024px) {
  .full-mountain-image {
    background-attachment: scroll;
  }
}

@media (max-width: 768px) {
  .Header-hero {
    padding: 1rem;
  }

  .scrolling-text {
    flex-direction: column;
    gap: 0.25rem;
  }
}

@media (max-width: 480px) {
  .hero-title {
    font-size: 1.8rem;
  }

  .Button {
    padding: 0.8rem 1.5rem;
    font-size: 0.9rem;
  }

  .Header-content {
    padding: 1rem;
  }
}
"@

# Navigation styles
$navStyles = @"
#menu {
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 900;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  display: flex;
  justify-content: flex-end;
  padding-right: 2rem;
  height: 60px;
  align-items: center;
}

.menu-item {
  padding: 0 1.5rem;
  display: inline-block;
}

.menu-text a {
  color: white;
  text-decoration: none;
  font-size: 1.1rem;
  transition: color 0.3s ease;
}

.menu-text a:hover {
  color: #64ffda;
}

.mobile-menu-toggle {
  display: none;
  position: fixed;
  top: 1.5rem;
  right: 2rem;
  z-index: 1001;
  background: none;
  border: none;
  color: white;
  font-size: 1.5rem;
  cursor: pointer;
}

@media (max-width: 768px) {
  .mobile-menu-toggle {
    display: block;
  }

  #menu {
    padding-right: 0;
    justify-content: center;
    flex-direction: column;
    height: auto;
    display: none;
  }

  #menu.active {
    display: flex;
  }

  .menu-item {
    padding: 1rem;
    width: 100%;
    text-align: center;
  }
}
"@

# Hero styles
$heroStyles = @"
.corner-logo {
  position: fixed;
  top: 1.5rem;
  left: 2rem;
  z-index: 1000;
  display: flex;
  align-items: center;
  text-decoration: none;
}

.corner-logo img {
  width: 40px;
  height: auto;
  transition: transform 0.3s ease;
}

.corner-logo:hover img {
  transform: scale(1.1);
}

.corner-logo-text {
  color: white;
  margin-left: 1rem;
  font-size: 1.2rem;
  font-weight: 600;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

.Header-content {
  padding: 2rem;
  text-align: center;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.Header-hero {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
}

.hero-logo {
  max-width: 120px;
  height: auto;
  margin-bottom: 2rem;
}

.hero-title {
  font-size: clamp(2rem, 5vw, 3.5rem);
  font-weight: 800;
  color: white;
  margin: 1.5rem 0;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
  line-height: 1.2;
}

.gradient-text {
  display: inline-block;
  padding: 0 0.2em;
  transition: all 0.3s ease;
}

.gradient-text:hover {
  color: transparent;
  background: linear-gradient(45deg, #64ffda, #48c6ef, #6f86d6, #64ffda);
  background-size: 300% 300%;
  -webkit-background-clip: text;
  background-clip: text;
  animation: gradient 3s ease infinite;
  cursor: pointer;
  transform: translateY(-2px);
}

@media (max-width: 768px) {
  .corner-logo {
    top: 1rem;
    left: 1rem;
  }

  .corner-logo img {
    width: 32px;
  }

  .corner-logo-text {
    font-size: 1rem;
  }
}

@media (max-width: 480px) {
  .corner-logo-text {
    display: none;
  }
}
"@

# Animation styles
$animationStyles = @"
/* Scrolling Text Animations */
.scrolling-text {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  margin: 2rem 0;
  flex-wrap: wrap;
  height: 1.8em;
}

.static-text {
  color: white;
  font-size: clamp(1rem, 3vw, 1.5rem);
}

.scrolling-text__container {
  height: 1.8em;
  overflow: hidden;
}

.scrolling-text__list {
  list-style: none;
  padding: 0;
  margin: 0;
  animation: scroll 10s infinite;
  transform-origin: top;
}

.scrolling-text__item {
  color: #64ffda;
  font-size: clamp(1rem, 3vw, 1.5rem);
  height: 1.8em;
  display: flex;
  align-items: center;
  justify-content: center;
}

@keyframes scroll {
  0% {
    transform: translateY(0);
  }
  25% {
    transform: translateY(0);
  }
  30% {
    transform: translateY(-1.8em);
  }
  50% {
    transform: translateY(-1.8em);
  }
  55% {
    transform: translateY(-3.6em);
  }
  75% {
    transform: translateY(-3.6em);
  }
  80% {
    transform: translateY(-5.4em);
  }
  100% {
    transform: translateY(-5.4em);
  }
}

@keyframes gradient {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}
"@

# Create or update CSS files
$cssFiles = @{
    "styles.css" = $mainStyles
    "nav.css" = $navStyles
    "hero.css" = $heroStyles
    "animations.css" = $animationStyles
}

foreach ($file in $cssFiles.Keys) {
    Set-SafeFile -Path "public/assets/css/$file" -Content $cssFiles[$file] -Description "CSS file: $file" -Overwrite $true
    Add-Content -Path $patchLog -Value "Updated CSS file: $file"
}

# Update patch log
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $patchLog -Value "[$timestamp] CSS modularization patch completed"

Write-Host "`nPatch 2 applied successfully!" -ForegroundColor Green
Write-Host "`nChanges made:" -ForegroundColor Yellow
Write-Host "1. Created/Updated styles.css (main styles)"
Write-Host "2. Created/Updated nav.css (navigation styles)"
Write-Host "3. Created/Updated hero.css (hero section styles)"
Write-Host "4. Created/Updated animations.css (animation styles)"
Write-Host "`nCheck patch_log.txt for details of changes made."

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Update your index.html to include the new CSS files"
Write-Host "2. Test the site to ensure styles are working"
Write-Host "3. Check patch_log.txt to review changes"

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")