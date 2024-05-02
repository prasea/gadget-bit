import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  validate(event) {
    const name = document.getElementById('category_name').value.trim();
    const description = document.getElementById('category_description').value.trim();

    const errorMessages = [];

    if (name === "") {
      errorMessages.push("Category name can't be blank");
    }

    if (description === "") {
      errorMessages.push("Category description can't be blank");
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

    const form = document.querySelector('form[data-controller="category-form-validation"]');
    const parentElement = form.parentElement;
    parentElement.insertBefore(alertDiv, form);

    setTimeout(() => {
      alertDiv.remove();
    }, 3000);
  }
}
