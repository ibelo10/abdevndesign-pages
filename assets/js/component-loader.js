// Component loader utility
class ComponentLoader {
  static async loadComponent(elementId, componentPath) {
    try {
      const response = await fetch(componentPath);
      if (!response.ok) throw new Error(`Failed to load ${componentPath}`);
      const content = await response.text();
      document.getElementById(elementId).innerHTML = content;
    } catch (error) {
      console.error("Error loading component:", error);
    }
  }

  static async loadAllComponents() {
    const components = {
      "nav-container": "/components/nav/nav.html",
      "hero-container": "/components/hero/hero.html",
      "portfolio-container": "/components/portfolio/portfolio.html",
    };

    // Load all components concurrently
    const loadPromises = Object.entries(components).map(([id, path]) =>
      this.loadComponent(id, path)
    );

    try {
      await Promise.all(loadPromises);
      // Initialize ripples after components are loaded
      this.initializeRipples();
    } catch (error) {
      console.error("Error loading components:", error);
    }
  }

  static initializeRipples() {
    if (typeof $ === "undefined") {
      console.error("jQuery not loaded");
      return;
    }

    try {
      $(".full-mountain-image").ripples({
        resolution: 512,
        dropRadius: 20,
        perturbance: 0.04,
        interactive: true,
        crossOrigin: "",
      });

      // Add automatic ripples
      setInterval(() => {
        const $el = $(".full-mountain-image");
        const x = Math.random() * $el.outerWidth();
        const y = Math.random() * $el.outerHeight();
        const dropRadius = 20;
        const strength = 0.04 + Math.random() * 0.04;

        $el.ripples("drop", x, y, dropRadius, strength);
      }, 3000);

      // Handle window resize
      let resizeTimeout;
      $(window).on("resize", () => {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(() => {
          try {
            $(".full-mountain-image").ripples("updateSize");
          } catch (e) {
            console.error("Resize error:", e);
          }
        }, 100);
      });
    } catch (error) {
      console.error("Error initializing ripples:", error);
    }
  }
}
