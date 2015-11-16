"use strict"

express = require("express")
path = require("path")
fs = require("fs")

router = express.Router()
router.get "/",  (req, res) ->
  language = req.query.lang.substring(0,2)
  getPath = (lang) -> path.join __dirname + '/' + lang + '.json'
  localePath = getPath language

  json = if fs.existsSync(localePath) then localePath else getPath('es')

  res.sendfile json

module.exports = router