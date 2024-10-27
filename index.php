<?php
    // Enable error reporting during development
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    // Helper function to safely include files
    function safeInclude($file) {
        if (file_exists($file)) {
            include $file;
        } else {
            echo "<!-- Error: Could not find $file -->";
        }
    }
?>
<!DOCTYPE html>
<html lang="en">
    <?php safeInclude('components/head.html'); ?>
    <body>
        <!-- Navigation Menu -->
        <?php safeInclude('components/nav/nav.html'); ?>
        
        <!-- Hero Section -->
        <?php safeInclude('components/hero/hero.html'); ?>
        
        <!-- Portfolio Section -->
        <?php safeInclude('components/portfolio/portfolio.html'); ?>
        
        <!-- Scripts -->
        <?php safeInclude('includes/scripts.html'); ?>
    </body>
</html>