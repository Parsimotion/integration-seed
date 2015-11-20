mongoose = require("mongoose")
Promise = require("bluebird")
Promise.promisifyAll mongoose
Schema = mongoose.Schema
_ = require("lodash")

module.exports =
  Types: Schema.Types

  create: ({ name, properties, methods, addToJSON }) ->
    schema = new Schema(properties)

    schema.method methods if methods?
    if addToJSON isnt false
      schema.method "toJSON", ->
        obj = @toObject()
        _(obj)
          .assign id: obj._id
          .omit "_id", "__v", "userId"
          .value()

    mongoose.model(name, schema)
