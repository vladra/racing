<template>
  <div>
    <race-table
      :drivers="drivers"
      :maxLaps="maxLaps"
    ></race-table>

    <div class="graph-buttons">
      <el-button-group>
        <el-button :type="buttonType('laps')" size="mini" @click="type = 'laps'">Laps</el-button>
        <el-button :type="buttonType('cumulative_laps')" size="mini" @click="type = 'cumulative_laps'">Cumulative laps</el-button>
        <el-button :type="buttonType('gaps')" size="mini" @click="type = 'gaps'">Gaps</el-button>
        <el-button :type="buttonType('cumulative_gaps')" size="mini" @click="type = 'cumulative_gaps'">Cumulative gaps</el-button>
      </el-button-group>
    </div>

    <race-chart
      :drivers="drivers"
      :maxLaps="maxLaps"
      :type="type"
    ></race-chart>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex';

import RaceTable from '../components/RaceTable';
import RaceChart from '../components/RaceChart';

export default {
  components: {
    'race-table': RaceTable,
    'race-chart': RaceChart,
  },

  data() {
    return {
      type: 'laps'
    };
  },

  computed: {
    ...mapGetters(['drivers', 'maxLaps']),
  },

  methods: {
    buttonType(type) {
      return (type === this.type) ? 'success' : 'primary';
    }
  },

  created() {
    const id = this.$route.params.id;
    this.$store.dispatch('fetchRace', id);
  }
}
</script>

<style>
.graph-buttons {
  text-align: center;
  margin: 20px 0;
}
</style>
