import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  validate(event) {
    const quantityField = document.getElementById('stock_quantity');
    const quantity = parseInt(quantityField.value.trim(), 10); 

    if (isNaN(quantity) || quantity <= 0 || !Number.isInteger(quantity)) {
      quantityField.classList.add("is-invalid");
      this.displayAlert("Quantity must be a positive integer.");
      event.preventDefault();
    } else {
      quantityField.classList.remove("is-invalid");
    }
  }

  displayAlert(message) {
    const alertDiv = document.createElement("div");
    alertDiv.classList.add("alert", "alert-danger");
    alertDiv.textContent = message;

    const form = document.querySelector("form[data-controller='stock-form-validation']");
    const parentElement = form.parentElement;
    parentElement.insertBefore(alertDiv, form);

    setTimeout(() => {
      alertDiv.remove();
    }, 5000);
  }
}
