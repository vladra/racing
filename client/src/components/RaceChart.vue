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
            },
          }],
        },
        tooltips: {
          callbacks: {
            label: (item, _data) => msToTime(item.yLabel),
          }
        },
      };
    },
  },
}
</script>
