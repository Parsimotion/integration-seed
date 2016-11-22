_ = require "lodash"
passport = require("passport")

passport.serializeUser ({ _id: id }, done) ->
  encodedTokens = new Buffer(JSON.stringify({ id })).toString("base64")
  done null, encodedTokens

passport.deserializeUser (encodedTokens, done) ->
  tokens = JSON.parse(new Buffer(encodedTokens, "base64").toString("utf8"))
  done null, tokens
