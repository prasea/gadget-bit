import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["quantity"];

  validate(event) {
    const quantityInput = this.quantityTarget;
    const quantity = parseInt(quantityInput.value.trim(), 10);

    if (isNaN(quantity) || quantity <= 0 || !Number.isInteger(quantity) || quantity >= 5 ) {
      quantityInput.classList.add("is-invalid");
      this.displayAlert("Invalid quantity. Quantity must be a positive integer less than 5.");
      event.preventDefault();
    } else {
      quantityInput.classList.remove("is-invalid");
    }
  }

  displayAlert(message) {
    const alertDiv = document.createElement("div");
    alertDiv.classList.add("alert", "alert-danger");
    alertDiv.textContent = message;

    // const form = this.element;

    const form = document.querySelector("form[data-controller='cart-quantity-validation']");
    const parentElement = form.parentElement.parentElement;
    // parentElement.appendChild(alertDiv);
    parentElement.insertBefore(alertDiv, parentElement.firstChild); 
    setTimeout(() => {
      alertDiv.remove();
    }, 2000);
  }
}
