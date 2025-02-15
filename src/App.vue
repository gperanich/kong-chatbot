<template>
  <img class="kong-logo" alt="Vue logo" src="./assets/konglogo.png">
  <h1>Kong Chatbot</h1>
   <ChatBot/>
</template>

<script>
import ChatBot from './components/ChatBot.vue'

export default {
  name: 'App',
  components: {
    ChatBot
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

.kong-logo {
  height: 200px;
}
</style>
