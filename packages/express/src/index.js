const express = require('express')
const app = express()

app.get('/', function (req, res) {
  res.send('Boring default text')
})

const server = app.listen(3000)

module.exports = {
  app: app, 
  server: server
}