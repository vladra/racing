<template>
  <div>
    <el-row>
      <el-col>
        <h1 class="title" style="text-align: center;">
          Race results
          <span class="supplementary">(click row to open particular race)</span>
        </h1>
      </el-col>
    </el-row>

    <el-row>
      <el-col>
    <el-table
      v-loading="loadingRaces"
      :data="races"
      empty-text="No data"
      :stripe="true"
      @row-click="handleRowClick">
      <el-table-column align="center" prop="name" label="Name"></el-table-column>
      <el-table-column align="center" prop="location" label="Location"></el-table-column>
      <el-table-column align="center" prop="date" label="Date"></el-table-column>
      <el-table-column align="center" label="">
        <template slot-scope="scope">
          <el-button size="small">Open</el-button>
        </template>
      </el-table-column>
    </el-table>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex';

export default {
  computed: {
    ...mapState(['races', 'loadingRaces']),
  },

  methods: {
    handleRowClick(row, e, col) {
      this.$router.push({ name: 'race', params: { id: row.id } })
    },
  },

  created() {
    if (this.races.length === 0) {
      this.$store.dispatch('fetchRaces');
    }
  }
};
</script>
