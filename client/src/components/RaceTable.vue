<template>
  <el-table
    :data="drivers"
  >
    <el-table-column
      fixed
      prop="number"
      label="Number"
      width="100"
    ></el-table-column>
    <el-table-column
      prop="name"
      label="Name"
      width="200"
    ></el-table-column>
    <el-table-column
      v-for="(n, i) in maxLaps"
      :prop="`laps.${i}.ms`"
      :label="`Lap ${n}`"
      :formatter="msToTime"
      :key="n"
    ></el-table-column>
    <el-table-column
      prop="total_ms"
      label="Total time"
      :formatter="msToTime"
    ></el-table-column>
  </el-table>
</template>

<script>
import { msToTime } from '../utility/time_helpers';

export default {
  name: 'race-table',

  props: ['drivers', 'maxLaps'],

  methods: {
    msToTime(_row, _col, ms) {
      return msToTime(ms);
    },
  },
}
</script>
