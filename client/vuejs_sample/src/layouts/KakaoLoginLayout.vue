<template>
  <div>
    <button type="button" id="kakao-btn" v-on:click="kakaoLogin">
      <img src="../assets/kakao_login_medium_narrow.png" alt="#"/>
    </button>
  </div>
</template>

<script>
export default {
  data: () => ({
    client_id: "304eb08fa8bf41613f2c9b6aece62720",
    redirect_uri: "http://localhost:8080/auth/kakao-callback",
  }),
  computed: {

  },
  methods: {
    kakaoLogin: function () {
      const url =`https://kauth.kakao.com/oauth/authorize?client_id=${this.client_id}&redirect_uri=${this.redirect_uri}&response_type=code`
      return window.location.href = url;
    },
  }
}
</script>

<style>
#kakao-btn {
  padding: 0;
  border: none;
  border-radius: 5px;
}
</style>