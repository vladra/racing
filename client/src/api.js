import axios from 'axios';

axios.defaults.baseURL = 'http://localhost:9393';

const fetchRace = id =>
  axios
    .get(`/api/races/${id}`)
    .then(response => response.data)
    .catch((error) => {
      throw error;
    });

export { fetchRace };
