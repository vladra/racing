<template>
  <div>
    <race-table :drivers="drivers">
    </race-table>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex';

import RaceTable from '../components/RaceTable';

export default {
  components: {
    'race-table': RaceTable,
  },

  computed: {
    ...mapGetters(['drivers']),
  },

  created () {
    const id = this.$route.params.id;
    this.$store.dispatch('fetchRace', id);
  }
}
</script>

<style>
</style>
