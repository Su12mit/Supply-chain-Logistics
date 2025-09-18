document.getElementById('nextButton').addEventListener('click', function() {
    const signupType = document.getElementById('signupType').value;
    if (signupType === 'personal') {
        window.open('PRT_signup.html', '_blank');
    } else if (signupType === 'company') {
        window.open('CMT_signup.html', '_blank');
    }
});