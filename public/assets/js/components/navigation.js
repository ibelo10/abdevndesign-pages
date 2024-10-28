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
