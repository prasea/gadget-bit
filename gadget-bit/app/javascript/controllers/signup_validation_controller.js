import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  
  validate(event) {
    const email = document.getElementById('user_email').value.trim();
    const name = document.getElementById('user_name').value.trim();
    const contact = document.getElementById('user_contact').value.trim();
    const password = document.getElementById('user_password').value.trim();
    const passwordConfirmation = document.getElementById('user_password_confirmation').value.trim();
    
    const errorMessages = [];

    if (email === '') {
      errorMessages.push("Email can't be blank");
    }

    if (name === '') {
      errorMessages.push("Name can't be blank");
    }

    if (contact === '') {
      errorMessages.push("Contact can't be blank");
    }

    if (password === '') {
      errorMessages.push("Password can't be blank");
    } else if (password.length < 6) {
      errorMessages.push("Password must be at least 6 characters long");
    }

    if (passwordConfirmation === '') {
      errorMessages.push("Password Confirmation can't be blank");
    } else if (passwordConfirmation.length < 6) {
      errorMessages.push("Confirmation password must be at least 6 characters long");
    }

    if (errorMessages.length > 0) {
      this.displayAlert(errorMessages);
      event.preventDefault();
    }
  }

  displayAlert(messages) {
    const alertDiv = document.createElement('div');
    alertDiv.classList.add('alert', 'alert-danger');

    const ul = document.createElement('ul');
    messages.forEach(message => {
      const li = document.createElement('li');
      li.textContent = message;
      ul.appendChild(li);
    });
    alertDiv.appendChild(ul);

    const form = document.querySelector('form[data-controller="signup-validation"]');
    const parentElement = form.parentElement;
    parentElement.insertBefore(alertDiv, form);

    setTimeout(() => {
      alertDiv.remove();
    }, 5000);
  }
}
