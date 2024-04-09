import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  validate(event) {
    const minPriceInput = document.querySelector("#min_price");
    const maxPriceInput = document.querySelector("#max_price");

    const minPrice = minPriceInput.value.trim();
    const maxPrice = maxPriceInput.value.trim();
    if ((minPrice === '' && maxPrice === '') || parseFloat(minPrice) < 0 || parseFloat(maxPrice) < 0) {
      const alertDiv = document.createElement('div');
      alertDiv.classList.add('alert', 'alert-danger');
      alertDiv.textContent = 'Please enter valid price.';

      const form = document.querySelector('form[data-controller="price-filter"]');
      const parentElement = form.parentElement;
      parentElement.insertBefore(alertDiv, form);

      setTimeout(() => {
        alertDiv.remove();
      }, 3000);

      event.preventDefault(); 
    }
  }
}
