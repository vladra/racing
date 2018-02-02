import axios from 'axios';

if (process.env.NODE_ENV === 'production') {
  axios.defaults.baseURL = '';
} else {
  axios.defaults.baseURL = 'http://localhost:9393';
}

const fetchRaces = () =>
  axios
    .get('/api/races')
    .then(response => response.data)
    .catch((error) => {
      throw error;
    });

const fetchRace = id =>
  axios
    .get(`/api/races/${id}`)
    .then(response => response.data)
    .catch((error) => {
      throw error;
    });

export { fetchRaces, fetchRace };
