ObjectId = require('mongoose').Types.ObjectId
exceptions = include("domain/exceptions")
_ = require("lodash")
module.exports =
# ---

class Home
  constructor: (@Model, @user) ->

  getAll: =>
    @Model.findAsync(@_query()).then (entities) =>
      Promise.all entities.map @_populate_

  get: (id) =>
    @Model.findOneAsync @_query @_makeId(id)
    .then (entity) =>
      if not entity? then throw exceptions.entityNotFound
      @_populate entity

  create: (entity) =>
    @Model.createAsync @_query entity

  update: (id, updatedFields) =>
    @get(id).then (entity) =>
      _.assign entity, @_transformUpdate_(updatedFields)
      entity.saveAsync()

  delete: (id) =>
    @Model.removeAsync @_query @_makeId(id)

  _makeId: (id) => _id: try ObjectId id
  _query: (query = {}) =>
    _.merge query, userId: @user.id

  # can be overriden...
  _transformUpdate_: (model) => model
  _populate_: (model) => model
