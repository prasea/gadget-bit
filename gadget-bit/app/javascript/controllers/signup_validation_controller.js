import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  
  validate(event) {
    const emailField = document.getElementById('user_email');
    const nameField = document.getElementById('user_name');
    const contactField = document.getElementById('user_contact');
    const passwordField = document.getElementById('user_password');
    const passwordConfirmationField = document.getElementById('user_password_confirmation');
    
    const errorMessages = [];

    if (emailField.value.trim() === '') {
      errorMessages.push("Email can't be blank");
      this.addErrorClass(emailField);
    } else {
      this.removeErrorClass(emailField);
    }

    if (nameField.value.trim() === '') {
      errorMessages.push("Name can't be blank");
      this.addErrorClass(nameField);
    } else {
      this.removeErrorClass(nameField);
    }

    if (contactField.value.trim() === '') {
      errorMessages.push("Contact can't be blank");
      this.addErrorClass(contactField);
    } else {
      this.removeErrorClass(contactField);
    }

    if (passwordField.value.trim() === '') {
      errorMessages.push("Password can't be blank");
      this.addErrorClass(passwordField);
    } else if (passwordField.value.trim().length < 6) {
      errorMessages.push("Password must be at least 6 characters long");
      this.addErrorClass(passwordField);
    } else {
      this.removeErrorClass(passwordField);
    }

    if (passwordConfirmationField.value.trim() === '') {
      errorMessages.push("Password Confirmation can't be blank");
      this.addErrorClass(passwordConfirmationField);
    } else if (passwordConfirmationField.value.trim().length < 6) {
      errorMessages.push("Confirmation password must be at least 6 characters long");
      this.addErrorClass(passwordConfirmationField);
    } else {
      this.removeErrorClass(passwordConfirmationField);
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

  addErrorClass(element) {
    element.classList.add('is-invalid');
  }

  removeErrorClass(element) {
    element.classList.remove('is-invalid');
  }
}
