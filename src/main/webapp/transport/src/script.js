//TRSIGNUP



// Updated scripts.js
function nextPage(pageNumber) {
    const currentPage = document.querySelector('.form-page.active');
    const fields = currentPage.querySelectorAll('input, select');
    
    for (let field of fields) {
        if (!field.checkValidity()) {
            field.reportValidity();
            return;
        }
    }

    currentPage.classList.remove('active');
    document.getElementById(`page-${pageNumber}`).classList.add('active');
}

function previousPage(pageNumber) {
    const currentPage = document.querySelector('.form-page.active');
    currentPage.classList.remove('active');
    document.getElementById(`page-${pageNumber}`).classList.add('active');
}

function updateVehicleOptions() {
    const vehicleType = document.getElementById('vehicle-type').value;
    const vehicleOptions = document.getElementById('vehicle-options');
    
    vehicleOptions.innerHTML = '';
    
    if (vehicleType === 'truck') {
        vehicleOptions.innerHTML = `<label for="no-of-trucks">Number of Trucks:</label><input type="number" id="no-of-trucks" name="no-of-trucks" required>`;
    } else if (vehicleType === 'van') {
        vehicleOptions.innerHTML = `<label for="no-of-vans">Number of Vans:</label><input type="number" id="no-of-vans" name="no-of-vans" required>`;
    } else if (vehicleType === 'container-carriers') {
        vehicleOptions.innerHTML = `<label for="no-of-container-carriers">Number of Container Carriers:</label><input type="number" id="no-of-container-carriers" name="no-of-container-carriers" required>`;
    } else if (vehicleType === 'truck-and-van') {
        vehicleOptions.innerHTML = `<label for="no-of-trucks">Number of Trucks:</label><input type="number" id="no-of-trucks" name="no-of-trucks" required><label for="no-of-vans">Number of Vans:</label><input type="number" id="no-of-vans" name="no-of-vans" required>`;
    }
}

document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('page-1').classList.add('active');
});

/* CMT SIGNUP*/
