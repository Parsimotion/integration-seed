# Environment variables
# Export your process.env variables here!

Promise = require("bluebird")
connection = require("mongoose").connection
seed = require("./seed")
nock = require("nock")
_ = require("lodash")

# Clean all the db
beforeEach ->
  nock.cleanAll()

  collections = Promise.promisifyAll connection.collections

  $cleanCollections = _(collections)
    .mapValues (it) => it.removeAsync()
    .values()
    .value()

  Promise.all($cleanCollections).then seed.createAll
