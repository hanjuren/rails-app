<template>
  <div>
    <h3>카카오 콜백 페이지 입니다.</h3>
  </div>
</template>

<script>
export default {
  data: () => {
    return {
      authorize_code: ""
    }
  },
  created() {
    this.getCodeToToken();
  },
  methods: {
    getCodeToToken: function() {
      this.authorize_code = this.$route.query.code
      console.log("hello world")
      console.log(this.authorize_code);

      const url = "/api/v1/auth/kakao_login";
      const params = {
        code: this.authorize_code,
        redirect_uri: 'http://localhost:8080/auth/kakao-callback',
        provider: 'kakao'
      }
      this.$axios.post(url, params)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log(error);
        })
    }
  },
}
</script>

<style></style>