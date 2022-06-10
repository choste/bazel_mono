const express = require('express')
const app = express()

app.get('/', function (req, res) {
  res.send('White boy summer')
})

app.listen(3000)