# Environment variables
# Export your process.env variables here!

Promise = require("bluebird")
mongoose = require("mongoose")
connection = require("mongoose").connection
seed = require("./seed")
config = require("../config/environment")
nock = require("nock")
_ = require("lodash")

# Disable net connections
nock.disableNetConnect()
nock.enableNetConnect('127.0.0.1')

mongoose.connect config.mongo.uri, config.mongo.options

# Clean all the db
beforeEach ->
  nock.cleanAll()

  collections = Promise.promisifyAll connection.collections

  $cleanCollections = _(collections)
    .mapValues (it) => it.removeAsync()
    .values()
    .value()

  Promise.all($cleanCollections).then seed.createAll
