# Patch 6 script for AB Development & Design website - Services Section
Write-Host "Applying Services Section patch..." -ForegroundColor Cyan

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
Add-Content -Path $patchLog -Value "`n[$timestamp] Starting Services Section patch..."

# Services CSS content
$servicesCSS = @"
/* Services Section Styles */
.services-section {
    background: #111;
    padding: 6rem 2rem;
    position: relative;
    overflow: hidden;
}

.services-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(100, 255, 218, 0.3), transparent);
}

.services-container {
    max-width: 1200px;
    margin: 0 auto;
}

.services-title {
    text-align: center;
    color: white;
    font-size: clamp(2rem, 5vw, 3rem);
    margin-bottom: 4rem;
    position: relative;
}

.services-title::after {
    content: '';
    display: block;
    width: 60px;
    height: 4px;
    background: #64ffda;
    margin: 1rem auto;
    border-radius: 2px;
}

.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    padding: 1rem;
}

.service-card {
    background: rgba(255, 255, 255, 0.05);
    border-radius: 15px;
    padding: 2rem;
    transition: all 0.3s ease;
    border: 1px solid rgba(100, 255, 218, 0.1);
    backdrop-filter: blur(10px);
    position: relative;
    overflow: hidden;
}

.service-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(100, 255, 218, 0.2), transparent);
    transform: translateX(-100%);
    transition: transform 0.5s ease;
}

.service-card:hover {
    transform: translateY(-5px);
    border-color: rgba(100, 255, 218, 0.3);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.service-card:hover::before {
    transform: translateX(100%);
}

.service-icon {
    font-size: 2.5rem;
    color: #64ffda;
    margin-bottom: 1.5rem;
    transition: transform 0.3s ease;
}

.service-card:hover .service-icon {
    transform: scale(1.1);
}

.service-title {
    color: white;
    font-size: 1.5rem;
    margin-bottom: 1rem;
    font-weight: 600;
}

.service-description {
    color: #a0aec0;
    line-height: 1.6;
    font-size: 1rem;
}

.service-features {
    margin-top: 1.5rem;
    padding-top: 1.5rem;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.feature-item {
    color: #a0aec0;
    font-size: 0.9rem;
    margin: 0.5rem 0;
    display: flex;
    align-items: center;
}

.feature-item i {
    color: #64ffda;
    margin-right: 0.5rem;
    font-size: 0.8rem;
}

/* Responsive Adjustments */
@media (max-width: 768px) {
    .services-section {
        padding: 4rem 1rem;
    }

    .services-grid {
        grid-template-columns: 1fr;
        gap: 1.5rem;
    }

    .service-card {
        padding: 1.5rem;
    }
}

@media (max-width: 480px) {
    .services-section {
        padding: 3rem 1rem;
    }

    .services-title {
        font-size: 1.8rem;
    }

    .service-title {
        font-size: 1.3rem;
    }
}
"@

# Services Component HTML content
$servicesHTML = @"
<section id="services" class="services-section">
    <div class="services-container">
        <h2 class="services-title">Our Services</h2>
        <div class="services-grid">
            <!-- Web Development -->
            <div class="service-card">
                <div class="service-icon">
                    <i class="fas fa-code"></i>
                </div>
                <h3 class="service-title">Web Development</h3>
                <p class="service-description">
                    Custom web solutions built with modern technologies and best practices.
                </p>
                <div class="service-features">
                    <div class="feature-item">
                        <i class="fas fa-check"></i>
                        <span>Responsive Design</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-check"></i>
                        <span>Modern Frameworks</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-check"></i>
                        <span>Performance Optimization</span>
                    </div>
                </div>
            </div>

            <!-- UI/UX Design -->
            <div class="service-card">
                <div class="service-icon">
                    <i class="fas fa-paint-brush"></i>
                </div>
                <h3 class="service-title">UI/UX Design</h3>
                <p class="service-description">
                    Beautiful and intuitive interfaces designed with user experience in mind.
                </p>
                <div class="service-features">
                    <div class="feature-item">
                        <i class="fas fa-check"></i>
                        <span>User-Centered Design</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-check"></i>
                        <span>Interactive Prototypes</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-check"></i>
                        <span>Brand Identity</span>
                    </div>
                </div>
            </div>

            <!-- Mobile Development -->
            <div class="service-card">
                <div class="service-icon">
                    <i class="fas fa-mobile-alt"></i>
                </div>
                <h3 class="service-title">Mobile Development</h3>
                <p class="service-description">
                    Native and cross-platform mobile applications for iOS and Android.
                </p>
                <div class="service-features">
                    <div class="feature-item">
                        <i class="fas fa-check"></i>
                        <span>Cross-Platform Apps</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-check"></i>
                        <span>Native Performance</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-check"></i>
                        <span>App Store Publishing</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
"@

# Create or update files
Set-SafeFile -Path "public/assets/css/services.css" -Content $servicesCSS -Description "services.css" -Overwrite $true
Set-SafeFile -Path "public/components/services/services.html" -Content $servicesHTML -Description "services component" -Overwrite $true

# Update patch log
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $patchLog -Value "[$timestamp] Services Section patch completed"

Write-Host "`nPatch 6 applied successfully!" -ForegroundColor Green
Write-Host "`nChanges made:" -ForegroundColor Yellow
Write-Host "1. Created services.css with:"
Write-Host "   - Modern card design"
Write-Host "   - Hover animations"
Write-Host "   - Responsive layout"
Write-Host "2. Created services component with:"
Write-Host "   - Three main service cards"
Write-Host "   - Feature lists"
Write-Host "   - Icons and descriptions"

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Add services.css link to index.html if not already present"
Write-Host "2. Test responsive behavior"
Write-Host "3. Verify animations and hover effects"
Write-Host "4. Consider adding more services or customizing content"

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")