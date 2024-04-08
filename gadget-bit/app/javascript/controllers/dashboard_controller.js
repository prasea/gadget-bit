import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js'

Chart.register(...registerables)

export default class extends Controller {
  initialize() {
    const data = [10, 20, 30, 40, 50, 60, 70]
    const labels = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    const context = document.getElementById('revenueChart')
    new Chart(context, {
      type: 'line', 
      data: {
        labels: labels, 
        datasets: [{
          label: 'Revenue NPR', 
          data: data, 
          borderWidth: 3, 
          fill: true
        }]
      }, 
      options: {
        plugins: {
          legend: { display: false }
        }, 
        scales: {
          x: {
            grid: { display: false }
          }, 
          y: {
            borderColor: { dash: [5, 5] }, 
            grid: { color: "#d4f3ef" }, 
            beginAtZero: true
          }
        }
      }
    })
  }
}
