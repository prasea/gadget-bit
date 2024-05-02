import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  validate(event) {
    const nameInput = document.getElementById("product_name");
    const descriptionInput = document.getElementById("product_description");
    const priceInput = document.getElementById("product_price");
    const imagesInput = document.getElementById("product_images");

    const errorMessages = [];

    if (nameInput.value.trim() === "") {
      errorMessages.push("Product name can't be blank");
      nameInput.classList.add("is-invalid");
    } else {
      nameInput.classList.remove("is-invalid");
    }

    if (descriptionInput.value.trim() === "") {
      errorMessages.push("Product description can't be blank");
      descriptionInput.classList.add("is-invalid");
    } else {
      descriptionInput.classList.remove("is-invalid");
    }

    const priceValue = parseFloat(priceInput.value.trim());
    if (isNaN(priceValue) || priceValue <= 0 || priceValue <= 20000) {
      errorMessages.push("Price must be a valid positive number greater than 20000");
      priceInput.classList.add("is-invalid");
    } else {
      priceInput.classList.remove("is-invalid");
    }
    
    const existingImage = document.querySelector('.img-fluid');   
    if ((imagesInput && imagesInput.files.length > 0) || existingImage) {
        const validImageTypes = ['image/jpeg', 'image/png'];
        let hasValidImage = false; 
    
        if (imagesInput && imagesInput.files.length > 0) {
          for (let i = 0; i < imagesInput.files.length; i++) {
            const file = imagesInput.files[i];
            if (validImageTypes.includes(file.type)) {
                hasValidImage = true;
            } else {
                errorMessages.push("Please upload only JPEG or PNG images.");
                imagesInput.classList.add("is-invalid");
                return; 
            }
          }
        } else {
          // If there's an existing image, consider it as a valid image
            hasValidImage = true; 
        }
        if (hasValidImage) {
            imagesInput.classList.remove("is-invalid");
        }
    } else {
        errorMessages.push("Please upload at least one image.");
        imagesInput.classList.add("is-invalid");
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

    const form = document.querySelector("form[data-controller='product-form-validation']");
    const parentElement = form.parentElement;
    parentElement.insertBefore(alertDiv, form);

    setTimeout(() => {
      alertDiv.remove();
    }, 5000);
  }
}
