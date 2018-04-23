<template>
  <el-table
    ref="raceTable"
    :data="drivers"
    size="small"
    empty-text="No data"
    highlight-current-row
    @row-click="handleRowClick"
    :stripe="true">
    <el-table-column
      fixed
      type="index"
      width="40"
    ></el-table-column>
    <el-table-column
      fixed
      prop="number"
      label="№"
      width="50"
    ></el-table-column>
    <el-table-column
      prop="name"
      label="Name"
      width="200">
    </el-table-column>
    <el-table-column
      v-for="(n, i) in maxLaps"
      :prop="`laps.${i}.ms`"
      :label="`Lap ${n}`"
      :formatter="msToTime"
      :key="n"
      width="100">
    </el-table-column>
    <el-table-column
      prop="total_ms"
      label="Total time"
      :formatter="msToTime"
      width="100">
    </el-table-column>
  </el-table>
</template>

<script>
import { mapActions, mapState } from 'vuex';

import { msToTime } from '../utility/time_helpers';

export default {
  name: 'race-table',

  props: ['drivers', 'maxLaps'],

  computed: {
    ...mapState(['selectedDriver']),
  },

  methods: {
    ...mapActions(['selectDriver']),

    msToTime(_row, _col, ms) {
      return msToTime(ms);
    },

    handleRowClick(row) {
      if (row.id === this.selectedDriver) {
        this.$refs.raceTable.setCurrentRow();
        this.selectDriver(null);
      } else {
        this.$refs.raceTable.setCurrentRow(row);
        this.selectDriver(row.id);
      }
    },
  },

  destroyed() {
    this.selectDriver(null);
  },
}
</script>
