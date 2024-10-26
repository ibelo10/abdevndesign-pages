// Component loader function
async function loadComponent(elementId, componentPath) {
  try {
    const response = await fetch(componentPath);
    const html = await response.text();
    document.getElementById(elementId).innerHTML = html;
  } catch (error) {
    console.error(`Error loading component from ${componentPath}:`, error);
  }
}

// Load all components
document.addEventListener("DOMContentLoaded", () => {
  loadComponent("nav-container", "components/nav/nav.html");
  loadComponent("hero-container", "components/hero/hero.html");
  loadComponent("portfolio-container", "components/portfolio/portfolio.html");
});
