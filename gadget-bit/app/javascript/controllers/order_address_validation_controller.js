import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["city", "area", "state", "landmark"];

  validate(event) {
    const cityInput = this.cityTarget;
    const areaInput = this.areaTarget;
    const stateInput = this.stateTarget;
    const landmarkInput = this.landmarkTarget;
  
    const cityValue = cityInput.value.trim();
    const areaValue = areaInput.value.trim();
    const stateValue = stateInput.value.trim();
    const landmarkValue = landmarkInput.value.trim();
  
    const errorMessages = [];
  
    if (!cityValue) {
      errorMessages.push("City can't be blank");
      cityInput.classList.add("is-invalid");
    } else {
      cityInput.classList.remove("is-invalid");
      cityInput.classList.add("is-valid");
    }
  
    if (!areaValue) {
      errorMessages.push("Area can't be blank");
      areaInput.classList.add("is-invalid");
    } else {
      areaInput.classList.remove("is-invalid");
      areaInput.classList.add("is-valid");
    }
  
    if (!stateValue) {
      errorMessages.push("State must be selected");
      stateInput.classList.add("is-invalid");
    } else {
      stateInput.classList.remove("is-invalid");
      stateInput.classList.add("is-valid");
    }

  
    if (errorMessages.length > 0) {
      this.displayAlert(errorMessages);
      event.preventDefault();
    }
  }
  

  displayAlert(messages) {
    const alertDiv = document.createElement("div");
    alertDiv.classList.add("alert", "alert-danger");

    const ul = document.createElement("ul");
    messages.forEach((message) => {
      const li = document.createElement("li");
      li.textContent = message;
      ul.appendChild(li);
    });
    alertDiv.appendChild(ul);

    const form = document.querySelector("form[data-controller='order-address-validation']");
    const parentElement = form.parentElement;
    parentElement.insertBefore(alertDiv, form);

    setTimeout(() => {
      alertDiv.remove();
    }, 5000);
  }
}
