const express = require('express')
const app = express()

app.get('/', function (req, res) {
  res.send('Hello World')
})

const server = app.listen(3000)

module.exports = {
  app: app, 
  server: server
}