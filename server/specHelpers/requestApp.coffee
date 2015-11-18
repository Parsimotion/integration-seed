Promise = require("bluebird")
request = Promise.promisifyAll require("supertest")
nock = require("nock")
app = include("app").app
_ = require("lodash")

nockProductecaUser = ->
  nock("http://auth.producteca.com")
    .get "/users/me"
    .reply 200, id: 5

module.exports = (verb, route, options, headers = {}) ->
  nockProductecaUser()

  req = request(app)[verb](route)
    .type "json"
    .set "Authorization", "Bearer sarasa"

  _.forOwn headers, (value, name) ->
    req.set name, value

  req
    .send options?.body
    .expect (options?.expectedStatus || 200)
    .endAsync()
