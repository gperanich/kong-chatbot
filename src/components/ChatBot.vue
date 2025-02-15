<template>
  <div class="chat-container">
    <div  v-if="messages.length > 0" class="chat-box">
      <div v-for="(message, index) in messages" :key="index" class="chat-message">
        <div class="user-message-container" v-if="message.role === 'user'">
          <p class="user-message">{{ message.content }}</p>
        </div>
        <div class="assistant-message-container" v-if="message.role === 'assistant'">
          <p class="assistant-message">{{ message.content }}</p>
          <KBadge class="response-time" v-if="responseTimes[Math.floor((index) / 2)]" :appearance="responseTimes[Math.floor((index) / 2)].appearance">{{ responseTimes[Math.floor((index) / 2)].response_time }}ms <span v-if="responseTimes[Math.floor((index) / 2)].cache">[from cache]</span></KBadge>
        </div>
      </div>
    </div>
    <div class="chat-input">
      <KInput v-model="newMessage" placeholder="Type your message here..." />
      <KButton appearance="primary" @click="sendMessage">Send</KButton>
    </div>
    <div v-if="showAlert">
      <KAlert
        dismissible
        appearance="danger"
        :message="error"
        @dismiss="hideAlert"
      />
    </div>
  </div>
</template>

<script>
import { KButton, KInput, KAlert, KBadge } from '@kong/kongponents'
import '@kong/kongponents/dist/style.css'
import axios from 'axios'

export default {
  name: 'ChatBot',
  components: { KButton, KInput, KAlert, KBadge },
  data() {
    return {
      messages: [],
      newMessage: '',
      error: null,
      showAlert: false,
      responseTimes: []
    }
  },
  methods: {
    async sendMessage() {
      if (this.newMessage.trim() === '') return

      this.messages.push({ role: 'user', content: this.newMessage })
      // const userMessage = this.newMessage
      this.newMessage = ''

      try {
        const startTime = performance.now()
        const response = await axios.post('http://localhost:8000/v1/chat/completions', {
          messages: this.messages,
        })
        const endTime = performance.now()
        const responseTime = Math.round(endTime - startTime)
        this.responseTimes.push({
          response_time: responseTime,
          appearance: this.getApperance(responseTime),
          cache: response.data["id"] ? true : false
        })

        console.log(response, this.responseTimes)

        this.messages.push(response.data.choices[0].message)

        if (this.error) {
          this.error = null
          this.showAlert = false
        }
        
      } catch (error) {
        console.error('Error sending message:', error)
        if (error.status === 400) {
          this.error = 'Error sending message: ' + error.response.data.error.message
          this.showAlert = true
        }
      }
    },
    hideAlert() {
      console.log('hideAlert')
      this.showAlert = false
      this.messages.pop()
    },
    getApperance(number) {
      if (number < 3000) {
        return 'success';
      } else if (number >= 3000 && number <= 10000) {
        return 'warning';
      } else {
        return 'danger';
      }
    },
    getResponsesIndex(index) {
      if (index == 0) {
        return 0
      }
      return Math.ceil((index) / 2)
    }
  }
}
</script>

<style scoped>
.chat-container {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.chat-box {
  flex: 1;
  overflow-y: auto;
  padding: 10px;
  border: 1px solid #ccc;
  margin-bottom: 10px;
}

.chat-message {
  margin-bottom: 10px;
}

.chat-input {
  display: flex;
  align-items: center;
}

.chat-input KInput {
  flex: 1;
  margin-right: 10px;
}

.user-message-container {
  display: flex;
  width: 100%;
  justify-content: flex-end;
}

.user-message {
  background-color: #f1f1f1;
  border-radius: 10px;
  padding: 10px;
  word-wrap: break-word;
}

.assistant-message-container {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  width: 100%;
}

.assistant-message {
  background-color: #e0e0e0;
  border-radius: 10px;
  padding: 10px;
  word-wrap: break-word;
}

.response-time {
  float: left;
  margin-top: 5px;
}
</style>
