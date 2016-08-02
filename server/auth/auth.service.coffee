User = include("domain/schemas/user.model")
passport = require("passport")
config = include("config/environment")
basicAuth = require("basic-auth")

reject = (res) -> res.send 401
login = (id, req, res, next) ->
  User
    .findByIdAsync id
    .then (user) ->
      if not user? then return reject res
      req.user = user ; next()
    .catch -> reject(res)

tryAuthenticateWithBasicAuth = (req) ->
  credentials = basicAuth req
  authenticated = credentials?.name? and credentials.pass is process.env.MASTER_TOKEN
  req.user = id: parseInt(credentials.name) if authenticated
  authenticated

exports.authenticated = (req, res, next) ->
  if not tryAuthenticateWithBasicAuth(req) and not req.isAuthenticated()
    return reject res

  login req.user.id, req, res, next

exports.logout = (req, res) ->
  req.logout()
  res.redirect "/"
