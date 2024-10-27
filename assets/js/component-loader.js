class ComponentLoader {
    constructor() {
        this.componentsCache = new Map();
        this.loadingComponents = new Set();
        this.onComponentLoaded = null;
        this.onAllComponentsLoaded = null;
    }

    async loadComponent(elementId, componentPath) {
        try {
            if (this.loadingComponents.has(componentPath)) {
                await this.waitForComponent(componentPath);
                return;
            }

            this.loadingComponents.add(componentPath);

            if (!this.componentsCache.has(componentPath)) {
                const response = await fetch(componentPath);
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const html = await response.text();
                this.componentsCache.set(componentPath, html);
            }

            const element = document.getElementById(elementId);
            if (!element) {
                console.warn(`Element with id "${elementId}" not found`);
                return;
            }

            element.innerHTML = this.componentsCache.get(componentPath);

            // Call the onComponentLoaded callback
            if (typeof this.onComponentLoaded === 'function') {
                this.onComponentLoaded(elementId);
            }

        } catch (error) {
            console.error(`Error loading component from ${componentPath}:`, error);
            this.handleError(elementId, error);
        } finally {
            this.loadingComponents.delete(componentPath);
        }
    }

    async waitForComponent(componentPath) {
        return new Promise(resolve => {
            const checkCache = setInterval(() => {
                if (!this.loadingComponents.has(componentPath)) {
                    clearInterval(checkCache);
                    resolve();
                }
            }, 100);
        });
    }

    handleError(elementId, error) {
        const element = document.getElementById(elementId);
        if (element) {
            element.innerHTML = `
                <div class="component-error">
                    <p>Error loading component</p>
                    <button onclick="componentLoader.retryLoad('${elementId}')">
                        Retry
                    </button>
                </div>
            `;
        }
    }

    async init() {
        try {
            await Promise.all([
                this.loadComponent("head-container", "/components/head.html"),
                this.loadComponent("nav-container", "/components/nav/nav.html"),
                this.loadComponent("hero-container", "/components/hero/hero.html"),
                this.loadComponent("portfolio-container", "/components/portfolio/portfolio.html")
            ]);

            // Call the onAllComponentsLoaded callback
            if (typeof this.onAllComponentsLoaded === 'function') {
                await this.onAllComponentsLoaded();
            }

        } catch (error) {
            console.error('Error during initialization:', error);
        }
    }

    async retryLoad(elementId) {
        const componentPaths = {
            'head-container': '/components/head.html',
            'nav-container': '/components/nav/nav.html',
            'hero-container': '/components/hero/hero.html',
            'portfolio-container': '/components/portfolio/portfolio.html'
        };

        const path = componentPaths[elementId];
        if (path) {
            this.componentsCache.delete(path);
            await this.loadComponent(elementId, path);
        }
    }
}

// Make componentLoader globally available
window.ComponentLoader = ComponentLoader;