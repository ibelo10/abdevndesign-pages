# Patch 3 script for AB Development & Design website - JS Organization and Components
Write-Host "Applying JavaScript and Components patch..." -ForegroundColor Cyan

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
Add-Content -Path $patchLog -Value "`n[$timestamp] Starting JavaScript and Components patch..."

# Main JavaScript
$mainJs = @"
// Main JavaScript file for AB Development & Design

document.addEventListener('DOMContentLoaded', () => {
    initializeRippleEffect();
    handleWindowResize();
});

function initializeRippleEffect() {
    try {
        $(".full-mountain-image").ripples({
            resolution: 512,
            dropRadius: 20,
            perturbance: 0.04,
        });
    } catch (e) {
        console.error('Error initializing ripple effect:', e);
    }
}

function handleWindowResize() {
    window.addEventListener('resize', () => {
        if (window.innerWidth > 768) {
            const menu = document.querySelector('#menu');
            const menuToggle = document.querySelector('.mobile-menu-toggle');
            if (menu && menuToggle) {
                menu.classList.remove('active');
                menuToggle.innerHTML = '<i class="fas fa-bars"></i>';
            }
        }
    });
}
"@

# Navigation JavaScript
$navigationJs = @"
// Navigation functionality

class Navigation {
    constructor() {
        this.menuToggle = document.querySelector('.mobile-menu-toggle');
        this.menu = document.querySelector('#menu');
        this.init();
    }

    init() {
        if (this.menuToggle && this.menu) {
            this.menuToggle.addEventListener('click', () => this.toggleMenu());
        }
    }

    toggleMenu() {
        this.menu.classList.toggle('active');
        this.menuToggle.innerHTML = this.menu.classList.contains('active')
            ? '<i class="fas fa-times"></i>'
            : '<i class="fas fa-bars"></i>';
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new Navigation();
});
"@

# Scroll Effects JavaScript
$scrollJs = @"
// Scroll effects and animations

class ScrollHandler {
    constructor() {
        this.init();
    }

    init() {
        this.handleSmoothScroll();
        this.handleScrollAnimations();
    }

    handleSmoothScroll() {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', (e) => {
                e.preventDefault();
                const target = document.querySelector(anchor.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }

    handleScrollAnimations() {
        // Add scroll-based animations here
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new ScrollHandler();
});
"@

# Create hero.html component
$heroHtml = @"
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
"@

# Create navigation.html component
$navigationHtml = @"
<button class="mobile-menu-toggle">
    <i class="fas fa-bars"></i>
</button>

<a href="/" class="corner-logo">
    <img src="/assets/images/AB-logo.png" alt="AB Dev & Design" />
    <span class="corner-logo-text">AB Development & Design</span>
</a>

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
"@

# Create or update JavaScript files
$jsFiles = @{
    "main.js" = $mainJs
    "components/navigation.js" = $navigationJs
    "components/scroll.js" = $scrollJs
}

foreach ($file in $jsFiles.Keys) {
    Set-SafeFile -Path "public/assets/js/$file" -Content $jsFiles[$file] -Description "JavaScript file: $file" -Overwrite $true
    Add-Content -Path $patchLog -Value "Updated JavaScript file: $file"
}

# Create or update component files
$components = @{
    "hero/hero.html" = $heroHtml
    "nav/navigation.html" = $navigationHtml
}

foreach ($component in $components.Keys) {
    Set-SafeFile -Path "public/components/$component" -Content $components[$component] -Description "Component file: $component" -Overwrite $true
    Add-Content -Path $patchLog -Value "Updated component file: $component"
}

# Update patch log
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $patchLog -Value "[$timestamp] JavaScript and Components patch completed"

Write-Host "`nPatch 3 applied successfully!" -ForegroundColor Green
Write-Host "`nChanges made:" -ForegroundColor Yellow
Write-Host "1. Created/Updated JavaScript files:"
Write-Host "   - main.js"
Write-Host "   - navigation.js"
Write-Host "   - scroll.js"
Write-Host "2. Created/Updated Components:"
Write-Host "   - hero.html"
Write-Host "   - navigation.html"
Write-Host "`nCheck patch_log.txt for details of changes made."

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Update your index.html to include the new JavaScript files"
Write-Host "2. Test the site to ensure all functionality is working"
Write-Host "3. Begin implementing additional components as needed"

Write-Host "`nExample index.html script includes:" -ForegroundColor Cyan
Write-Host @"
<script src="/assets/js/main.js"></script>
<script src="/assets/js/components/navigation.js"></script>
<script src="/assets/js/components/scroll.js"></script>
"@

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")