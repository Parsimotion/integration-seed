Promise = require("bluebird")
request = Promise.promisifyAll require("supertest")
app = include("app").app
nock = require("nock")
authServer = include("config/environment").producteca
mockedUser = require("./mockedUser")

module.exports = ->
  nock(authServer.tokenURL)
    .post ""
    .reply 200, access_token: "randomAccessToken"

  nock(authServer.profileUrl)
    .get "?access_token=randomAccessToken"
    .reply 200, mockedUser, {
      'Authorization': 'Bearer randomAccessToken'
      'Content-Type': 'application/json'
    }

  agent = request.agent app
  agent.login = ->
    @get("/auth/producteca/callback?code=randomCode").endAsync().then -> agent
  agent
