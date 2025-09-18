<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Page</title>
    <style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(to right, #131313, #242424);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    color: white;
}

.profile-container {
    width: 90%;
    max-width: 400px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(255, 255, 255, 0.2);
    text-align: center;
    position: relative;
    overflow: hidden;
    animation: fadeIn 1s ease-in-out;
}

/* Animated background */
.profile-container::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(45deg, rgba(255, 255, 0, 0.2), rgba(0, 255, 255, 0.2), rgba(255, 0, 255, 0.2));
    animation: animatedBackground 6s infinite alternate ease-in-out;
    z-index: -1;
    border-radius: inherit;
}

/* Background Animation */
@keyframes animatedBackground {
    0% {
        filter: blur(10px);
        transform: scale(1);
    }
    100% {
        filter: blur(15px);
        transform: scale(1.05);
    }
}

/* Page Fade-in */
@keyframes fadeIn {
    from { opacity: 0; transform: scale(0.9); }
    to { opacity: 1; transform: scale(1); }
}

/* Responsive Design */
@media (max-width: 480px) {
    .profile-container {
        width: 100%;
        padding: 15px;
    }
}

.save-btn {
    width: 100%;
    padding: 15px; /* Increased padding for larger button */
    font-size: 1.2rem; /* Bigger font size for emphasis */
    background: linear-gradient(45deg, #28a745, #218838); /* Professional green gradient */
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.4s ease-in-out;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 1px;
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
}

/* Button Hover Effect */
.save-btn:hover {
    background: linear-gradient(45deg, #218838, #28a745);
    transform: scale(1.05);
    box-shadow: 0 6px 20px rgba(40, 167, 69, 0.5);
}
 </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-card">
            <label class="profile-photo">
                <input type="file" id="uploadPhoto" accept="image/*">
                <img id="profileImage" src="default-profile.png" alt="Profile">
            </label>
            <h2>Company Name</h2>
            <input type="text" placeholder="Enter Company Name">
            
            <h3>Email</h3>
            <input type="email" placeholder="Enter Email">
            
            <h3>Contact</h3>
            <input type="text" placeholder="Enter Contact Number">
            
            <h3>Address</h3>
            <textarea placeholder="Enter Address"></textarea>

            <div class="notification">
                <label>
                    <input type="checkbox"> Enable Email Notifications
                </label>
            </div>
            
            <button class="save-btn">Save Changes</button>
        </div>
    </div>
    <script>
    document.getElementById('uploadPhoto').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('profileImage').src = e.target.result;
                document.getElementById('profileImage').style.boxShadow = "0 0 25px rgba(0, 255, 0, 1)";
            };
            reader.readAsDataURL(file);
        }
    });
    </script>
</body>
</html>