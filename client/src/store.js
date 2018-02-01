import Vue from 'vue';
import Vuex from 'vuex';

import { fetchRace } from './api';

Vue.use(Vuex);

const SET_RACE = 'SET_RACE';

const sortTime = (left, right) => {
  const lLaps = left.laps.length;
  const rLaps = right.laps.length;
  if (lLaps === rLaps) {
    return left.total_ms - right.total_ms;
  }
  return rLaps - lLaps;
};

export default new Vuex.Store({
  state: {
    race: {},
  },

  getters: {
    drivers: (state) => {
      const drivers = state.race.drivers || [];
      return drivers.sort(sortTime);
    },
  },

  mutations: {
    [SET_RACE](state, race) {
      state.race = race;
    },
  },

  actions: {
    async fetchRace({ commit }, id) {
      commit(SET_RACE, await fetchRace(id));
    },
  },
});
