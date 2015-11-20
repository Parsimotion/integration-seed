###*
Main application file
###

# Prettify errors
PrettyError = require("pretty-error") ; new PrettyError().start()

# Set default node environment to development
if process.env.NODE_ENV is "local" then process.env.NODE_ENV = ""
process.env.NODE_ENV = process.env.NODE_ENV or "development"
express = require("express")
mongoose = require("mongoose")
config = require("./config/environment")

# Connect to database
mongoose.connect config.mongo.uri, config.mongo.options

# Populate DB with sample data
require "./config/seed" if config.seedDB

# Setup server
app = express()
server = require("http").createServer(app)
require("./config/express") app
require("./routes") app

exports = module.exports =
  app: app
  server: server
  ip: config.ip
  port: config.port
  env: app.get "env"
