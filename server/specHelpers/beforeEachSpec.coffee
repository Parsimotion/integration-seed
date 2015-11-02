Promise = require("bluebird")
connection = require("mongoose").connection
seed = require("./seed")
_ = require("lodash")

# Clean all the db
beforeEach ->
  collections = Promise.promisifyAll connection.collections

  $cleanCollections = _(collections)
    .mapValues (it) => it.removeAsync()
    .values()
    .value()

  Promise.all($cleanCollections).then seed.createAll