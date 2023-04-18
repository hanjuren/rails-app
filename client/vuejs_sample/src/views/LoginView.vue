<template>
  <div>
    <h1>로그인 페이지 입니다.</h1>
    <kakao-login></kakao-login>
  </div>
</template>

<script>
import KakaoLoginLayout from "@/layouts/KakaoLoginLayout.vue";
export default {
  components: {
    'kakao-login': KakaoLoginLayout,
  }
}
</script>

<style>
h1 {
  color: black;
}
</style>