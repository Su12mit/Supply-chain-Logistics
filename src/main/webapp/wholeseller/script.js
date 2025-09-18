const sections = document.querySelectorAll('.section');
const nextBtns = document.querySelectorAll('.next-btn');
const prevBtns = document.querySelectorAll('.prev-btn');

let currentSection = 0; 

const backgroundColors = [
    '#f0f0f0', // Initial background color
    '#e0e0e0', // Background color for section 2
    '#d0d0d0', // Background color for section 3
    '#c0c0c0'  // Background color for section 4
];

nextBtns.forEach((btn, index) => {
    btn.addEventListener('click', () => {
        sections[currentSection].style.display = 'none';
        currentSection++;
        sections[currentSection].style.display = 'block';

        // Change background color
        document.body.style.backgroundColor = backgroundColors[currentSection]; 
    });
});

prevBtns.forEach((btn, index) => {
    btn.addEventListener('click', () => {
        sections[currentSection].style.display = 'none';
        currentSection--;
        sections[currentSection].style.display = 'block';

        // Change background color
        document.body.style.backgroundColor = backgroundColors[currentSection]; 
    });
});
