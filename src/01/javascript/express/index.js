const express = require('express')
const timeout = require('connect-timeout')
const dateFormat = require('dateformat')

const app = express()
const port = 3000
const myLogger = (req, res, next) => {
  console.log(dateFormat(new Date(), "isoUtcDateTime"), req.url, req.method, res.statusCode)
  next()
}

app.use(myLogger)
app.use(timeout('30s'))

app.get('/hello', (req, res) => {
  req.setTimeout(15000)
  res.append('Content-Type', 'text/plain')

  res.send('Hello\n')
})

app.listen(port, () => {
  console.log(`An app listening at http://localhost:${port}`)
})
