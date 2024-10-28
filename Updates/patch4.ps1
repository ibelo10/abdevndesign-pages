# Patch 4 script for AB Development & Design website - Index Update
Write-Host "Applying Index HTML Update patch..." -ForegroundColor Cyan

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
Add-Content -Path $patchLog -Value "`n[$timestamp] Starting Index HTML Update patch..."

# Updated index.html content
$indexContent = @"
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AB Development & Design</title>

    <!-- Fonts -->
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome -->
    <script
      src="https://kit.fontawesome.com/628c8d2499.js"
      crossorigin="anonymous"
    ></script>

    <!-- Styles -->
    <link rel="stylesheet" href="/assets/css/styles.css" />
    <link rel="stylesheet" href="/assets/css/nav.css" />
    <link rel="stylesheet" href="/assets/css/hero.css" />
    <link rel="stylesheet" href="/assets/css/animations.css" />
  </head>
  <body>
    <!-- Mobile Menu Toggle -->
    <button class="mobile-menu-toggle">
      <i class="fas fa-bars"></i>
    </button>

    <!-- Corner Logo -->
    <a href="/" class="corner-logo">
      <img src="/assets/images/AB-logo.png" alt="AB Dev & Design" />
      <span class="corner-logo-text">AB Development & Design</span>
    </a>

    <div class="full-mountain-image">
      <!-- Navigation -->
      <nav id="menu">
        <div class="menu-item">
          <div class="menu-text">
            <a href="#hero">Home</a>
          </div>
        </div>
        <div class="menu-item">
          <div class="menu-text">
            <a href="#services">Services</a>
          </div>
        </div>
        <div class="menu-item">
          <div class="menu-text">
            <a href="#portfolio">Portfolio</a>
          </div>
        </div>
        <div class="menu-item">
          <div class="menu-text">
            <a href="#contact">Contact</a>
          </div>
        </div>
      </nav>

      <!-- Hero Content -->
      <div class="Header-content">
        <div class="Header-hero">
          <img
            src="/assets/images/AB-logo.png"
            alt="AB Development & Design"
            class="hero-logo"
          />
          <h1 class="hero-title">
            <span class="gradient-text">AB</span>
            <span class="gradient-text">Development</span>
            <span class="gradient-text">&</span>
            <span class="gradient-text">Design</span>
          </h1>

          <div class="scrolling-text">
            <span class="static-text">We</span>
            <div class="scrolling-text__container">
              <ul class="scrolling-text__list">
                <li class="scrolling-text__item">create digital experiences</li>
                <li class="scrolling-text__item">build innovative solutions</li>
                <li class="scrolling-text__item">design beautiful interfaces</li>
                <li class="scrolling-text__item">transform your vision</li>
              </ul>
            </div>
            <span class="static-text">with passion</span>
          </div>

          <a href="#portfolio" class="Button">VIEW PORTFOLIO</a>
        </div>
      </div>
    </div>

    <!-- Additional Sections -->
    <section id="services" class="section">
      <div class="section-content">
        <!-- Services content will be loaded here -->
      </div>
    </section>

    <section id="portfolio" class="section">
      <div class="section-content">
        <!-- Portfolio content will be loaded here -->
      </div>
    </section>

    <section id="contact" class="section">
      <div class="section-content">
        <!-- Contact content will be loaded here -->
      </div>
    </section>

    <!-- External Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.ripples/0.5.3/jquery.ripples.min.js"></script>
    
    <!-- Internal Scripts -->
    <script src="/assets/js/main.js"></script>
    <script src="/assets/js/components/navigation.js"></script>
    <script src="/assets/js/components/scroll.js"></script>
  </body>
</html>
"@

# Create or update index.html
Set-SafeFile -Path "public/index.html" -Content $indexContent -Description "index.html" -Overwrite $true
Add-Content -Path $patchLog -Value "Updated index.html with modular structure"

# Update patch log
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $patchLog -Value "[$timestamp] Index HTML Update patch completed"

Write-Host "`nPatch 4 applied successfully!" -ForegroundColor Green
Write-Host "`nChanges made:" -ForegroundColor Yellow
Write-Host "1. Updated index.html with:"
Write-Host "   - Modular CSS imports"
Write-Host "   - Modular JavaScript imports"
Write-Host "   - Section placeholders for future content"
Write-Host "   - Updated navigation structure"
Write-Host "`nCheck patch_log.txt for details of changes made."

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Verify all styles are loading correctly"
Write-Host "2. Test JavaScript functionality"
Write-Host "3. Begin implementing content for services, portfolio, and contact sections"

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")