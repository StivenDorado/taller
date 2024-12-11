// src/services/api.js
import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:3000/registeri', 
  headers: {
    'Content-Type': 'application/json'
  }
});

export const getData = () => api.get('/tu-endpoint');
export const postData = (data) => api.post('/otro-endpoint', data);
