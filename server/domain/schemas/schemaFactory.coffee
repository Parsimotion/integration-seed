mongoose = require("mongoose")
denormalize = require("mongoose-denormalize")
Promise = require("bluebird")
Promise.promisifyAll mongoose
Schema = mongoose.Schema
_ = require("lodash")

module.exports =
  Types: Schema.Types

  create: ({ name, properties, methods, transform = (->), addToJSON = true }) ->
    schema = new Schema(properties)

    schema.method methods if methods?
    if addToJSON
      schema.method "toJSON", ->
        obj = @toObject()
        _(obj)
          .assign id: obj._id
          .omit "_id", "__v", "userId"
          .value()

    schema.propertiesDefinition = properties

    transform schema

    mongoose.model name, schema

  denormalize: (schema, { from, to}) ->
    options =
      if to?
        _.mapValues schema.propertiesDefinition, (value, key) ->
          to: to
          ref: key
      else if from?
        { localProperty, foreignSchema } = from

        _.mapValues foreignSchema.propertiesDefinition, (value) ->
          from: localProperty
          type: value.type or value
      else throw "unknown `from` or `to`"

    schema.plugin denormalize, options

  joinSchemasOf: (father, son, foreignKey) ->
    getProperties = (it) -> it.schema.propertiesDefinition

    _.assign {}, getProperties(father),
      _.mapKeys getProperties(son), (value, key) ->
        "#{foreignKey}_#{key}"
