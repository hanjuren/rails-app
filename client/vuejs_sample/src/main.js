import { createApp } from 'vue'
import App from './App.vue'
import router from './router/index.js';
import axios from "axios";

import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap"

const axiosInstance = axios.create({
    baseURL: "http://localhost:3000",
    withCredentials: true,
})


const app = createApp(App)

app.config.globalProperties.$axios = { ...axiosInstance }

app.use(router)

app.mount('#app')
