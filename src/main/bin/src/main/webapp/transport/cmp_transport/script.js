// Get all sidebar items
const sidebarItems = document.querySelectorAll('.sidebar-item');

// Add event listeners to each sidebar item
sidebarItems.forEach(item => {
    item.addEventListener('click', () => {
        const sectionId = item.querySelector('span').textContent.toLowerCase(); // Get section ID from text content
        const targetSection = document.getElementById(sectionId); // Get the target section element

        if (targetSection) {
            targetSection.scrollIntoView({ behavior: 'smooth' }); // Scroll smoothly to the section
        }
    });
});