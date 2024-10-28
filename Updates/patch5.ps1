# Patch 5 script for AB Development & Design website - Scroll Text Alignment Fix
Write-Host "Applying Scroll Text Alignment patch..." -ForegroundColor Cyan

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
Add-Content -Path $patchLog -Value "`n[$timestamp] Starting Scroll Text Alignment patch..."

# Updated animations.css content
$animationsContent = @"
/* Scrolling Text Animations */
.scrolling-text {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  margin: 2rem 0;
  flex-wrap: nowrap;
  height: 1.8em;
  text-align: center;
}

.static-text {
  color: white;
  font-size: clamp(1rem, 3vw, 1.5rem);
  white-space: nowrap;
}

.scrolling-text__container {
  height: 1.8em;
  overflow: hidden;
  width: auto;
  min-width: 220px;
  display: inline-block;
}

.scrolling-text__list {
  list-style: none;
  padding: 0;
  margin: 0;
  animation: scroll 10s infinite;
  transform-origin: top;
  text-align: center;
}

.scrolling-text__item {
  color: #64ffda;
  font-size: clamp(1rem, 3vw, 1.5rem);
  height: 1.8em;
  display: flex;
  align-items: center;
  justify-content: center;
  white-space: nowrap;
}

@keyframes scroll {
  0%, 20% {
    transform: translateY(0);
  }
  25%, 45% {
    transform: translateY(-1.8em);
  }
  50%, 70% {
    transform: translateY(-3.6em);
  }
  75%, 95% {
    transform: translateY(-5.4em);
  }
  100% {
    transform: translateY(-7.2em);
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

/* Mobile Responsive Adjustments */
@media (max-width: 768px) {
  .scrolling-text {
    flex-direction: row;
    gap: 0.5rem;
    justify-content: center;
  }

  .scrolling-text__container {
    min-width: 180px;
  }
}

@media (max-width: 480px) {
  .scrolling-text {
    margin: 1rem 0;
  }

  .scrolling-text__container {
    min-width: 160px;
  }

  .static-text,
  .scrolling-text__item {
    font-size: 1rem;
  }
}
"@

# Updated hero content with fixed scroll structure
$heroContent = @"
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
          <li class="scrolling-text__item">create digital experiences</li>
        </ul>
      </div>
      <span class="static-text">with passion</span>
    </div>

    <a href="#portfolio" class="Button">VIEW PORTFOLIO</a>
  </div>
</div>
"@

# Update animations.css
Set-SafeFile -Path "public/assets/css/animations.css" -Content $animationsContent -Description "animations.css" -Overwrite $true
Add-Content -Path $patchLog -Value "Updated animations.css with improved scroll text styles"

# Update hero component
Set-SafeFile -Path "public/components/hero/hero.html" -Content $heroContent -Description "hero component" -Overwrite $true
Add-Content -Path $patchLog -Value "Updated hero.html with fixed scroll text structure"

# Update patch log
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $patchLog -Value "[$timestamp] Scroll Text Alignment patch completed"

Write-Host "`nPatch 5 applied successfully!" -ForegroundColor Green
Write-Host "`nChanges made:" -ForegroundColor Yellow
Write-Host "1. Updated animations.css with:"
Write-Host "   - Fixed scroll text container width"
Write-Host "   - Improved text alignment"
Write-Host "   - Better animation timing"
Write-Host "   - Enhanced mobile responsiveness"
Write-Host "2. Updated hero component with:"
Write-Host "   - Duplicated first item for smooth loop"
Write-Host "   - Fixed container structure"
Write-Host "`nCheck patch_log.txt for details of changes made."

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Test the scroll text animation"
Write-Host "2. Verify mobile responsiveness"
Write-Host "3. Check text alignment across different screen sizes"

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")