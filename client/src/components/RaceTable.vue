<template>
  <el-table
    :data="drivers"
  >
    <el-table-column
      fixed
      prop="number"
      label="Number"
    ></el-table-column>
    <el-table-column
      prop="name"
      label="Name"
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
const pad = function(str, size = 2) {
  let s = String(str);
  while (s.length < (size || 2)) {s = "0" + s;}
  return s;
}

export default {
  name: 'race-table',

  props: ['drivers'],

  computed: {
    maxLaps() {
      const lapsAmount = this.drivers.map(({ laps = [] }) => laps.length);
      return Math.max(1, ...lapsAmount);
    }
  },

  methods: {
    msToTime(_row, _col, ms) {
      if (!ms) return '-';
      const mm = Math.floor(ms % 1000);
      const s = Math.floor(ms / 1000 % 60);
      const m = Math.floor(ms / 1000 / 60 % 60);
      const h = Math.floor(ms / 1000 / 60 / 60 % 60);
      return `${pad(h)}:${pad(m)}:${pad(s)}:${pad(mm, 3)}`;
    }
  },
}
</script>
