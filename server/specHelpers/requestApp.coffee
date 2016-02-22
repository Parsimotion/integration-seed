Promise = require("bluebird")
nock = require("nock")
agent = require("./agent")
_ = require("lodash")

nockProductecaUser = ->
  nock("http://auth.producteca.com")
    .get "/users/me"
    .reply 200, id: 5

module.exports = (verb, route, options, headers = {}) ->
  nockProductecaUser()

  agent().login().then (agent) ->
    req = agent[verb](route)
      .set "Authorization", "Bearer sarasa"

    if options?.body? then req.type "json"

    _.forOwn headers, (value, name) ->
      req.set name, value

    req
      .send options?.body
      .expect (options?.expectedStatus || 200)
      .endAsync()