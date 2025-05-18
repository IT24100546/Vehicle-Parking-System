function validateForm(formId) {
    const form = document.getElementById(formId);
    const inputs = form.querySelectorAll('input[required]');
    let isValid = true;

    inputs.forEach(input => {
        if (!input.value.trim()) {
            isValid = false;
            input.classList.add('is-invalid');
        } else {
            input.classList.remove('is-invalid');
        }
    });

    if (!isValid) {
        alert('Please fill in all required fields.');
    }
    return isValid;
}

function confirmDelete() {
    return confirm('Are you sure you want to delete your account? This action cannot be undone.');
}