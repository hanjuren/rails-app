import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '@/views/LoginView.vue';
import TodoList from "@/components/TodoList.vue";
import HomeView from "@/views/HomeView.vue";
import KakaoCallbackView from "@/views/KakaoCallbackView.vue";


const routes = [
    { path: '/', component: HomeView },
    { path: '/auth/login', component: LoginView },
    { path: '/todo-list', component: TodoList },
    { path: '/auth/kakao-callback', component: KakaoCallbackView },
]

const router = createRouter({
    history: createWebHistory(),
    routes, // `routes: routes`와 같음
})

export default router
