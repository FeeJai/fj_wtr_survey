import BaseChartHook from "./base-chart-hook";

export default {
  ...BaseChartHook,
  getConfig() {
    return {
      type: 'bar',
      data: {
        labels: ["left", "right"],
        datasets: [{
          label: 'Allocation Distribution',
          data: [65, 59],
          backgroundColor: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(255, 159, 64, 0.2)'
          ],
          borderColor: [
            'rgb(255, 99, 132)',
            'rgb(255, 159, 64)'
          ],
          borderWidth: 1
        }]
      },
      options: {
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    };
  }
}




