import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-search"
export default class extends Controller {
  validate(event) {
    const searchInput = document.getElementById('search');
    const searchedQuery = searchInput.value.trim();
    if (!searchedQuery) {
      const alertDiv = document.createElement('div');
      alertDiv.classList.add('alert', 'alert-danger');
      alertDiv.textContent = 'Please enter search query.';
      
      const form = document.querySelector('form[data-controller="product-search"]');
      const parentElement = form.parentElement;
      parentElement.insertBefore(alertDiv, form);

      setTimeout(() => {
        alertDiv.remove();
      }, 3000);

      event.preventDefault(); 
    }
  }
}
