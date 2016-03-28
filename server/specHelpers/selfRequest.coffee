Promise = require("bluebird")
nock = require("nock")
agent = require("./agent")
_ = require("lodash")

nockProductecaUser = ->
  nock("http://auth.producteca.com")
    .get "/users/me"
    .reply 200, id: 1234

selfRequest = (verb, route) ->
  nockProductecaUser()

  agent().login().then (agent) =>
    req = agent[verb](route).set "Authorization", "Bearer sarasa"

    if @body? then req.type "json"
    if @basicAuthCredentials?
      req.auth @basicAuthCredentials.username, @basicAuthCredentials.password

    _.forOwn (@headers or {}), (value, name) ->
      req.set name, value

    req
      .send @body
      .expect (@expectedStatus or 200)
      .endAsync()

module.exports =
  withBody: (body) -> @_set "body", body
  withBasicAuth: (credentials) -> @_set "basicAuthCredentials", credentials
  withHeaders: (headers) -> @_set "headers", headers
  withExpectedStatus: (expectedStatus) -> @_set "expectedStatus", expectedStatus
  get: _.partial selfRequest, "get"
  post: _.partial selfRequest, "post"
  put: _.partial selfRequest, "put"
  delete: _.partial selfRequest, "delete"
  withOptions: (options) ->
    instance = _.cloneDeep @
    _.forOwn options, (v, k) => instance[k] = v
    instance
  _set: (property, value) ->
    instance = _.cloneDeep @
    instance[property] = value
    instance
