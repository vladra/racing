import Vue from 'vue';
import Vuex from 'vuex';

import { fetchRaces, fetchRace } from './api';
import { sortDriversByTime } from './utility/time_helpers';

Vue.use(Vuex);

const SET_RACES = 'SET_RACES';
const SET_RACE = 'SET_RACE';
const LOAD_RACES = 'LOAD_RACES';
const LOAD_RACE = 'LOAD_RACE';
const TOGGLE_CHART_LINE = 'TOGGLE_CHART_LINE';

export default new Vuex.Store({
  state: {
    races: [],
    race: {},
    hiddenChartLines: [],
    loadingRaces: false,
    loadingRace: false,
  },

  getters: {
    drivers: (state) => {
      const drivers = state.race.drivers || [];
      return drivers.sort(sortDriversByTime);
    },

    maxLaps: (state, getters) => {
      const lapsAmount = getters.drivers.map(({ laps = [] }) => laps.length);
      return Math.max(1, ...lapsAmount);
    },

    isChartLineHidden: (state) => {
      return i => state.hiddenChartLines.includes(i);
    },
  },

  mutations: {
    [LOAD_RACES](state, isLoading) { state.loadingRaces = isLoading; },
    [LOAD_RACE](state, isLoading) { state.loadingRace = isLoading; },

    [SET_RACES](state, races) {
      state.races = races;
    },

    [SET_RACE](state, race) {
      state.race = race;
      state.hiddenChartLines = [];
    },

    [TOGGLE_CHART_LINE](state, { i, add }) {
      const { hiddenChartLines: hidden } = state;

      const incl = hidden.includes(i);

      if (add && !incl) {
        if (!hidden.includes(i)) hidden.push(i);
      }

      if (!add && incl) {
        state.hiddenChartLines = hidden.filter(el => el !== i);
      }
    },
  },

  actions: {
    async fetchRaces({ commit }) {
      commit(LOAD_RACES, true);
      commit(SET_RACES, await fetchRaces());
      commit(LOAD_RACES, false);
    },

    async fetchRace({ commit }, id) {
      commit(LOAD_RACE, true);
      commit(SET_RACE, await fetchRace(id));
      commit(LOAD_RACE, false);
    },

    toggleChartLines({ commit }, { i, add }) {
      commit(TOGGLE_CHART_LINE, { i, add });
    },
  },
});
