<template>
  <div>
    <h3>카카오 콜백 페이지 입니다.</h3>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      authorize_code: ""
    }
  },
  created() {
    this.authorize_code = this.$route.query.code

    this.getCodeToToken();
  },
  methods: {
    getCodeToToken: function() {
      console.log("hello world")
      console.log(this.authorize_code);
      axios.get("http://localhost:3000/api/v1/meta", { "code": this.authorize_code })
          .then((res) => {
            console.log(res.data)
          })
          .catch((err) => {
            console.log(err)
          })

      const url = "http://localhost:3000/api/v1/auth/kakao_login"
      const params = {
        code: this.authorize_code,
      }

      axios.post(
          url,
          params,
          {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          }
      )
          .then((res) => {
            console.log(res.data)
          })
          .catch((err) => {
            console.log(err)
          })
    }
  }
}
</script>

<style></style>