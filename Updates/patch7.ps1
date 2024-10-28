# Patch 7 script for AB Development & Design website - Portfolio Section
Write-Host "Applying Portfolio Section patch..." -ForegroundColor Cyan

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
Add-Content -Path $patchLog -Value "`n[$timestamp] Starting Portfolio Section patch..."

# Portfolio CSS content
$portfolioCSS = @"
/* Portfolio Section Styles */
.portfolio-section {
    background: #0a0a0a;
    padding: 6rem 2rem;
    position: relative;
    overflow: hidden;
}

.portfolio-container {
    max-width: 1200px;
    margin: 0 auto;
}

.portfolio-title {
    text-align: center;
    color: white;
    font-size: clamp(2rem, 5vw, 3rem);
    margin-bottom: 1rem;
}

.portfolio-subtitle {
    text-align: center;
    color: #64ffda;
    font-size: 1.1rem;
    margin-bottom: 3rem;
    opacity: 0.8;
}

/* Portfolio Filters */
.portfolio-filters {
    display: flex;
    justify-content: center;
    gap: 1rem;
    margin-bottom: 3rem;
    flex-wrap: wrap;
}

.filter-button {
    background: transparent;
    border: 1px solid rgba(100, 255, 218, 0.2);
    color: white;
    padding: 0.5rem 1.5rem;
    border-radius: 25px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 0.9rem;
}

.filter-button:hover,
.filter-button.active {
    background: rgba(100, 255, 218, 0.1);
    border-color: #64ffda;
    color: #64ffda;
}

/* Portfolio Grid */
.portfolio-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 2rem;
    padding: 1rem;
}

.portfolio-item {
    position: relative;
    border-radius: 15px;
    overflow: hidden;
    background: rgba(255, 255, 255, 0.05);
    transition: all 0.3s ease;
    aspect-ratio: 16/9;
}

.portfolio-item:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.portfolio-item-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: all 0.3s ease;
}

.portfolio-item-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.8);
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    opacity: 0;
    transition: all 0.3s ease;
    padding: 2rem;
}

.portfolio-item:hover .portfolio-item-overlay {
    opacity: 1;
}

.portfolio-item:hover .portfolio-item-image {
    transform: scale(1.1);
}

.portfolio-item-title {
    color: white;
    font-size: 1.5rem;
    margin-bottom: 1rem;
    text-align: center;
}

.portfolio-item-category {
    color: #64ffda;
    font-size: 0.9rem;
    margin-bottom: 1.5rem;
}

.portfolio-item-links {
    display: flex;
    gap: 1rem;
}

.portfolio-link {
    color: white;
    text-decoration: none;
    padding: 0.5rem 1rem;
    border: 1px solid rgba(100, 255, 218, 0.3);
    border-radius: 20px;
    font-size: 0.9rem;
    transition: all 0.3s ease;
}

.portfolio-link:hover {
    background: rgba(100, 255, 218, 0.1);
    border-color: #64ffda;
    color: #64ffda;
}

/* Modal Styles */
.portfolio-modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.9);
    z-index: 1000;
    padding: 2rem;
    overflow-y: auto;
}

.modal-content {
    max-width: 800px;
    margin: 2rem auto;
    background: #111;
    border-radius: 15px;
    padding: 2rem;
    position: relative;
}

.modal-close {
    position: absolute;
    top: 1rem;
    right: 1rem;
    background: none;
    border: none;
    color: white;
    font-size: 1.5rem;
    cursor: pointer;
    transition: color 0.3s ease;
}

.modal-close:hover {
    color: #64ffda;
}

.modal-image {
    width: 100%;
    border-radius: 10px;
    margin-bottom: 2rem;
}

.modal-title {
    color: white;
    font-size: 2rem;
    margin-bottom: 1rem;
}

.modal-description {
    color: #a0aec0;
    line-height: 1.6;
    margin-bottom: 2rem;
}

.modal-tech-stack {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
    margin-bottom: 2rem;
}

.tech-tag {
    background: rgba(100, 255, 218, 0.1);
    color: #64ffda;
    padding: 0.3rem 1rem;
    border-radius: 15px;
    font-size: 0.9rem;
}

/* Responsive Adjustments */
@media (max-width: 768px) {
    .portfolio-section {
        padding: 4rem 1rem;
    }

    .portfolio-grid {
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    }

    .modal-content {
        margin: 1rem;
    }
}

@media (max-width: 480px) {
    .portfolio-title {
        font-size: 1.8rem;
    }

    .portfolio-filters {
        gap: 0.5rem;
    }

    .filter-button {
        padding: 0.4rem 1rem;
        font-size: 0.8rem;
    }
}
"@

# Portfolio Component HTML content
$portfolioHTML = @"
<section id="portfolio" class="portfolio-section">
    <div class="portfolio-container">
        <h2 class="portfolio-title">Our Work</h2>
        <p class="portfolio-subtitle">Showcasing our latest projects and creations</p>

        <!-- Portfolio Filters -->
        <div class="portfolio-filters">
            <button class="filter-button active" data-filter="all">All</button>
            <button class="filter-button" data-filter="web">Web Development</button>
            <button class="filter-button" data-filter="design">UI/UX Design</button>
            <button class="filter-button" data-filter="mobile">Mobile Apps</button>
        </div>

        <!-- Portfolio Grid -->
        <div class="portfolio-grid">
            <!-- Portfolio Item 1 -->
            <div class="portfolio-item" data-category="web">
                <img src="/assets/images/portfolio/project1.jpg" alt="Project 1" class="portfolio-item-image">
                <div class="portfolio-item-overlay">
                    <h3 class="portfolio-item-title">E-Commerce Platform</h3>
                    <p class="portfolio-item-category">Web Development</p>
                    <div class="portfolio-item-links">
                        <a href="#" class="portfolio-link">View Details</a>
                        <a href="#" class="portfolio-link">Live Demo</a>
                    </div>
                </div>
            </div>

            <!-- Portfolio Item 2 -->
            <div class="portfolio-item" data-category="design">
                <img src="/assets/images/portfolio/project2.jpg" alt="Project 2" class="portfolio-item-image">
                <div class="portfolio-item-overlay">
                    <h3 class="portfolio-item-title">Mobile App UI</h3>
                    <p class="portfolio-item-category">UI/UX Design</p>
                    <div class="portfolio-item-links">
                        <a href="#" class="portfolio-link">View Details</a>
                        <a href="#" class="portfolio-link">Case Study</a>
                    </div>
                </div>
            </div>

            <!-- Portfolio Item 3 -->
            <div class="portfolio-item" data-category="mobile">
                <img src="/assets/images/portfolio/project3.jpg" alt="Project 3" class="portfolio-item-image">
                <div class="portfolio-item-overlay">
                    <h3 class="portfolio-item-title">Fitness Tracker App</h3>
                    <p class="portfolio-item-category">Mobile Development</p>
                    <div class="portfolio-item-links">
                        <a href="#" class="portfolio-link">View Details</a>
                        <a href="#" class="portfolio-link">App Store</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal Template -->
    <div class="portfolio-modal" id="portfolioModal">
        <div class="modal-content">
            <button class="modal-close">&times;</button>
            <img src="" alt="" class="modal-image">
            <h3 class="modal-title"></h3>
            <div class="modal-description"></div>
            <div class="modal-tech-stack"></div>
            <div class="portfolio-item-links">
                <a href="#" class="portfolio-link">Live Demo</a>
                <a href="#" class="portfolio-link">Source Code</a>
            </div>
        </div>
    </div>
</section>
"@

# Portfolio JavaScript content
$portfolioJS = @"
// Portfolio functionality
class PortfolioManager {
    constructor() {
        this.initializeFilters();
        this.initializeModal();
    }

    initializeFilters() {
        const filters = document.querySelectorAll('.filter-button');
        const items = document.querySelectorAll('.portfolio-item');

        filters.forEach(filter => {
            filter.addEventListener('click', () => {
                // Update active filter
                filters.forEach(f => f.classList.remove('active'));
                filter.classList.add('active');

                // Filter items
                const category = filter.dataset.filter;
                items.forEach(item => {
                    if (category === 'all' || item.dataset.category === category) {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        });
    }

    initializeModal() {
        const modal = document.getElementById('portfolioModal');
        const items = document.querySelectorAll('.portfolio-item');
        const closeBtn = modal.querySelector('.modal-close');

        items.forEach(item => {
            item.querySelector('.portfolio-link').addEventListener('click', (e) => {
                e.preventDefault();
                this.openModal(item);
            });
        });

        closeBtn.addEventListener('click', () => {
            modal.style.display = 'none';
        });

        window.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        });
    }

    openModal(item) {
        const modal = document.getElementById('portfolioModal');
        const title = item.querySelector('.portfolio-item-title').textContent;
        const image = item.querySelector('.portfolio-item-image').src;

        modal.querySelector('.modal-title').textContent = title;
        modal.querySelector('.modal-image').src = image;
        modal.style.display = 'block';
    }
}

// Initialize portfolio functionality
document.addEventListener('DOMContentLoaded', () => {
    new PortfolioManager();
});
"@

# Create or update files
Set-SafeFile -Path "public/assets/css/portfolio.css" -Content $portfolioCSS -Description "portfolio.css" -Overwrite $true
Set-SafeFile -Path "public/components/portfolio/portfolio.html" -Content $portfolioHTML -Description "portfolio component" -Overwrite $true
Set-SafeFile -Path "public/assets/js/components/portfolio.js" -Content $portfolioJS -Description "portfolio.js" -Overwrite $true

# Update patch log
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $patchLog -Value "[$timestamp] Portfolio Section patch completed"

Write-Host "`nPatch 7 applied successfully!" -ForegroundColor Green
Write-Host "`nChanges made:" -ForegroundColor Yellow
Write-Host "1. Created portfolio.css with:"
Write-Host "   - Responsive grid layout"
Write-Host "   - Hover effects and animations"
Write-Host "   - Modal styles"
Write-Host "2. Created portfolio component with:"
Write-Host "   - Filterable portfolio grid"
Write-Host "   - Project cards with overlays"
Write-Host "   - Modal for project details"
Write-Host "3. Added portfolio.js for:"
Write-Host "   - Filter functionality"
Write-Host "   - Modal interactions"

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Add your portfolio images to /assets/images/portfolio/"
Write-Host "2. Update project details in the HTML"
Write-Host "3. Test filter and modal functionality"
Write-Host "4. Add portfolio.js to your index.html"

Write-Host "`nAdd to index.html:" -ForegroundColor Cyan
Write-Host @"
<link rel="stylesheet" href="/assets/css/portfolio.css">
<script src="/assets/js/components/portfolio.js"></script>
"@

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")