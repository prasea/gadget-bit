import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  validate(event) {
    const email = document.getElementById('user_email').value.trim();
    const name = document.getElementById('user_name').value.trim();
    const contact = document.getElementById('user_contact').value.trim();
    const password = document.getElementById('user_password').value.trim();
    const passwordConfirmation = document.getElementById('user_password_confirmation').value.trim();
    
    if (email === '' || name === '' || contact === '' || password === '' || passwordConfirmation === ''){
      this.displayAlert("Fields can't be empty")
    }
    event.preventDefault();
  }

  displayAlert(message) {
    const alertDiv = document.createElement('div');
    alertDiv.classList.add('alert', 'alert-danger');
    alertDiv.textContent = message;

    const form = document.querySelector('form[data-controller="signup-validation"]');
    const parentElement = form.parentElement;
    parentElement.insertBefore(alertDiv, form);

    setTimeout(() => {
      alertDiv.remove();
    }, 3000);
  }
}

