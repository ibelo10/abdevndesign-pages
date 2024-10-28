// Main JavaScript file for AB Development & Design

document.addEventListener('DOMContentLoaded', () => {
    initializeRippleEffect();
    handleWindowResize();
});

function initializeRippleEffect() {
    try {
        .full-mountain-image.ripples({
            resolution: 512,
            dropRadius: 20,
            perturbance: 0.04,
        });
    } catch (e) {
        console.error('Error initializing ripple effect:', e);
    }
}

function handleWindowResize() {
    window.addEventListener('resize', () => {
        if (window.innerWidth > 768) {
            const menu = document.querySelector('#menu');
            const menuToggle = document.querySelector('.mobile-menu-toggle');
            if (menu && menuToggle) {
                menu.classList.remove('active');
                menuToggle.innerHTML = '<i class="fas fa-bars"></i>';
            }
        }
    });
}
