const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true
})

module.exports = {
  transpileDependencies: [
    /@kong\/kongponents/
  ]
}
