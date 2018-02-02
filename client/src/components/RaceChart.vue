<template>
  <line-chart :height="800" :chart-data="data" :options="options()"></line-chart>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';

import LineChart from './LineChart';
import { msToTime } from '../utility/time_helpers';

const colors = [
  '#a9b266',
  '#a456c6',
  '#57ba53',
  '#d44fab',
  '#9fb333',
  '#5e6ed9',
  '#d49a34',
  '#6f60a4',
  '#cf5829',
  '#5e9bd6',
  '#d4424c',
  '#4fb79b',
  '#cc3c72',
  '#4d7e3a',
  '#c78ed9',
  '#846f2c',
  '#9e4f7d',
  '#dc9167',
  '#e0819c',
  '#a2513f'
];

export default {
  props: ['drivers', 'maxLaps', 'type'],
  name: 'race-chart',
  components: {
    'line-chart': LineChart,
  },

  computed: {
    ...mapGetters(['isChartLineHidden']),

    data() {
      const labels = [];
      for (let i = 1; i <= this.maxLaps; i++) { labels.push(i) }

      const datasets = this.drivers.reduce((acc, driver, i) => {
        const data = {
          label: driver.name,
          backgroundColor: 'rgba(0, 0, 0, 0)',
          borderColor: colors[i],
          hidden: this.isChartLineHidden(i),
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
    ...mapActions(['toggleChartLines']),

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
            label: (item, data) => data.datasets[item.datasetIndex].label + ' ' + msToTime(item.yLabel),
          }
        },
        legend: {
          onClick: (e, item) => {
            const i = item.datasetIndex;
            const add = !item.hidden;
            this.toggleChartLines({ i, add });
          },
        },
      };
    },
  },
}
</script>
