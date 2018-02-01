<template>
  <line-chart :chart-data="data" :options="options()"
  ></line-chart>
</template>

<script>
import LineChart from './LineChart';
import { msToTime } from '../utility/time_helpers';

export default {
  props: ['drivers', 'maxLaps', 'type'],
  name: 'race-chart',
  components: {
    'line-chart': LineChart,
  },

  computed: {
    data() {
      const labels = [];
      for (let i = 1; i <= this.maxLaps; i++) { labels.push(i) }

      const datasets = this.drivers.reduce((acc, driver) => {
        const data = {
          label: driver.name,
          borderColor: '#' + (parseInt(driver.number) * 100000).toString(16).substring(0, 6),
          backgroundColor: 'rgba(0, 0, 0, 0)',
          data: driver[this.type].map(l => l.ms),
        }
        acc.push(data)
        return acc;
      }, []);

      return { labels, datasets };
    },

    fastestTime() {
      const laps = this.drivers.map(d => Math.min(...d.laps.map(l => l.ms)));
      return Math.min(...laps);
  },
  },

  methods: {
    options() {
      return {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          yAxes: [{
            ticks: {
              callback: (v, i, values) => {
                return msToTime(v);
              },
              stepValue: 1000 * 60,
              steps: 10,
              max: this.fastestTime + 1000 * 60 * 5
            },
          }],
        },
        tooltips: {
          callbacks: {
            label: (item, data) => data.datasets[item.datasetIndex].label + ' ' + msToTime(item.yLabel),
          }
        },
      };
    },
  },
}
</script>
