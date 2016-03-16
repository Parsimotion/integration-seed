Promise = require("bluebird")
request = Promise.promisifyAll require("supertest")
app = include("app").app
nock = require("nock")
authServer = include("config/environment").producteca
mockedUser = require("./mockedUser")

token = "randomAccessToken"
module.exports = ->
  nock(authServer.tokenURL)
    .post ""
    .reply 200, access_token: token

  nock(authServer.profileUrl)
    .get "?access_token=#{token}"
    .reply 200, mockedUser, {
      'Authorization': "Bearer #{token}"
      'Content-Type': "application/json"
    }

  agent = request.agent app
  agent.login = ->
    @get("/auth/wholesaler/callback?code=randomCode").endAsync().then -> agent
  agent
