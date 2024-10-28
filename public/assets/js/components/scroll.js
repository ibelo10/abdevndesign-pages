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
