Promise = require("bluebird")
request = Promise.promisifyAll require("supertest")
app = include("app").app
nock = require("nock")
authServer = include("config/environment").producteca

nock(authServer.tokenURL)
.post("")
.reply 200,
  access_token: "randomAccessToken"

nock(authServer.profileUrl)
.get "?access_token=randomAccessToken"
.reply 200,
  id: 1234
  email: "juan@gmail.com"
  company:
    id: 1234
    name: 'TIENDAONLINE'
  authorizations: [
    { app: 1, scopes: "all" }
  ]
  credentials:
    username: 'JuanPerez'
  profile:
    firstName: 'Juan'
    lastName: 'Perez'
,
  'Authorization': 'Bearer randomAccessToken'
  'Content-Type': 'application/json'

agent = request.agent(app)
agent.login = ->
  @get("/auth/producteca/callback?code=randomCode")
  .endAsync()

module.exports = agent
