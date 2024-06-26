export default {
  getConfig() {
    throw new Error("You must implement getConfig method");
  },
  getContext() {
    return this.el.getContext("2d");
  },
  insertChart() {
    import("chart.js/auto").then(({ default: Chart }) => {
      this.chart = new Chart(this.getContext(), this.getConfig(this));
    });
  },
  mounted() {
    this.insertChart();
  },
  updated() {
    this.chart.data.datasets[0].data = [
      this.el.dataset.youValue,
      this.el.dataset.participantValue,
    ];
    this.chart.update();
  },
};
