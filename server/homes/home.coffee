ObjectId = require('mongoose').Types.ObjectId
exceptions = include("domain/exceptions")
_ = require("lodash")
module.exports =
# ---

class Home
  constructor: (@Model, @user) ->

  getAll: =>
    @Model.findAsync @_query()

  get: (id) =>
    @Model.findOneAsync @_query @_makeId(id)
    .then (entity) =>
      if not entity? then throw exceptions.entityNotFound
      entity

  create: (entity) =>
    @Model.createAsync @_query entity

  update: (id, updatedFields) =>
    @get(id).then (entity) =>
      _.assign entity, @_transformUpdate_(updatedFields)
      @_transformEntity_ entity
      entity.saveAsync().then => @get id

  delete: (id) =>
    @Model.removeAsync(@_query @_makeId(id)).then => removed: true

  _makeId: (id) => _id: try ObjectId id
  _query: (query = {}) =>
    _.merge query, userId: @user.id

  # can be overriden...
  _transformUpdate_: (model) => _.omit model, "userId"
  _transformEntity_: =>
