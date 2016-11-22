###*
Main application routes
###
errors = require("./components/errors")
auth = require("./auth/auth.service")
express = require("express")
constants = require("./constants")

module.exports = (app) ->
  home = (req, res) ->
    if req.isAuthenticated()
      res.sendfile app.get("appPath") + "/main.html"
    else
      res.sendfile app.get("appPath") + "/landing.html"

  # Insert routes below
  app.get "/", home
  app.use "/api/users", require("./api/user")
  app.use "/api/settings", require("./api/settings")
  app.use "/auth", require("./auth")
  app.get "/constants.js", auth.authenticated, constants
  app.use "/locale", require("./locale")
  app.get "/logout", auth.logout

  # --- PUT MORE ROUTES HERE ---

  # Expose assets
  app.use express.static("assets")

  # All undefined asset or api routes should return a 404
  app.route("/:url(api|auth|components|app|bower_components|assets)/*").get errors[404]

  # All other routes should redirect to the home
  app.route("/*").get home
