# Patch script for AB Development & Design website
Write-Host "Applying project structure patch..." -ForegroundColor Cyan

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
        Set-Content -Path $Path -Value $Content
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
Add-Content -Path $patchLog -Value "`n[$timestamp] Starting patch application..."

# Create new directories
$newDirectories = @(
    "public/components/services",
    "public/components/about",
    "public/components/contact",
    "public/assets/videos",
    "public/assets/js/components"
)

foreach ($dir in $newDirectories) {
    $created = New-SafeDirectory -Path $dir
    if ($created) {
        Add-Content -Path $patchLog -Value "Created directory: $dir"
    }
}

# Create or update package.json with new dependencies
$currentPackageJson = $null
if (Test-Path "package.json") {
    $currentPackageJson = Get-Content "package.json" -Raw | ConvertFrom-Json
}

if ($null -eq $currentPackageJson) {
    $packageJson = @"
{
  "name": "ab-dev-design",
  "version": "1.0.0",
  "description": "AB Development & Design website",
  "scripts": {
    "dev": "netlify dev",
    "build": "netlify build"
  },
  "dependencies": {
    "@netlify/functions": "^2.0.0",
    "axios": "^1.6.0"
  },
  "devDependencies": {
    "netlify-cli": "^15.0.0"
  }
}
"@
    Set-SafeFile -Path "package.json" -Content $packageJson -Description "package.json" -Overwrite $true
    Add-Content -Path $patchLog -Value "Created new package.json"
} else {
    Write-Host "package.json exists - checking for updates" -ForegroundColor Yellow
    # Add logic here if you need to update package.json in the future
}

# Create component loader function
$functionDir = "netlify/functions/component-loader"
New-SafeDirectory -Path $functionDir

$functionContent = @"
const axios = require('axios');

exports.handler = async (event, context) => {
  try {
    const { component } = event.queryStringParameters;
    // Component loading logic here
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ message: 'Component loaded successfully' })
    };
  } catch (error) {
    return { 
      statusCode: 500, 
      body: JSON.stringify({ error: 'Failed to load component' }) 
    };
  }
};
"@
Set-SafeFile -Path "$functionDir/component-loader.js" -Content $functionContent -Description "component-loader function"

# Create new CSS files without overwriting existing ones
$newCssFiles = @{
    "services.css" = "/* Services section styles */"
    "about.css" = "/* About section styles */"
    "contact.css" = "/* Contact section styles */"
}

foreach ($file in $newCssFiles.Keys) {
    Set-SafeFile -Path "public/assets/css/$file" -Content $newCssFiles[$file] -Description "CSS file: $file"
}

# Create new JavaScript component files
$newJsFiles = @{
    "components/navigation.js" = "// Navigation functionality"
    "components/scroll.js" = "// Scroll effects"
}

foreach ($file in $newJsFiles.Keys) {
    Set-SafeFile -Path "public/assets/js/$file" -Content $newJsFiles[$file] -Description "JavaScript file: $file"
}

# Create new component files
$newComponents = @(
    "services/services.html",
    "about/about.html",
    "contact/contact.html"
)

foreach ($component in $newComponents) {
    $content = "<!-- $($component.Split('/')[0].ToUpper()) Section -->"
    Set-SafeFile -Path "public/components/$component" -Content $content -Description "component file: $component"
}

# Update patch log
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $patchLog -Value "[$timestamp] Patch application completed"

Write-Host "`nPatch applied successfully!" -ForegroundColor Green
Write-Host "`nChanges made:" -ForegroundColor Yellow
Write-Host "1. Added new component directories"
Write-Host "2. Created component loader function"
Write-Host "3. Added new CSS and JavaScript files"
Write-Host "4. Created new component templates"
Write-Host "`nCheck patch_log.txt for details of changes made."

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Run 'npm install' to install any new dependencies"
Write-Host "2. Check patch_log.txt to review changes"
Write-Host "3. Resume development with 'netlify dev'"

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")