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
