<template>
  <div>
    <h3>카카오 콜백 페이지 입니다.</h3>
  </div>
</template>

<script>
export default {
  data() {
    return {}
  },
  methods: {
    getCodeToToken: function() {
      const authorize_code = this.$route.query.code

      const url = "/api/v1/sign_in_kakao"
      const params = {
        code: authorize_code,
        redirect_uri: 'http://localhost:8080/auth/kakao-callback',
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
  mounted() {
    this.getCodeToToken()
  },
}
</script>

<style></style>