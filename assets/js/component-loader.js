class ComponentLoader {
  constructor() {
    this.componentsCache = new Map();
  }

  async loadComponent(elementId, componentPath) {
    try {
      if (!this.componentsCache.has(componentPath)) {
        const response = await fetch(componentPath);
        const html = await response.text();
        this.componentsCache.set(componentPath, html);
      }
      const componentHtml = this.componentsCache.get(componentPath);
      document.getElementById(elementId).innerHTML = componentHtml;
    } catch (error) {
      console.error(`Error loading component from ${componentPath}:`, error);
    }
  }

  async init() {
    await Promise.all([
      this.loadComponent("head-container", "/components/head.html"),
      this.loadComponent("nav-container", "/components/nav/nav.html"),
      this.loadComponent("hero-container", "/components/hero/hero.html"),
      this.loadComponent(
        "portfolio-container",
        "/components/portfolio/portfolio.html"
      ),
    ]);

    // Initialize any scripts that depend on loaded components
    if (window.initPortfolio) window.initPortfolio();
  }
}

// Initialize the component loader
const componentLoader = new ComponentLoader();
document.addEventListener("DOMContentLoaded", () => componentLoader.init());
