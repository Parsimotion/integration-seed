passport = require("passport")
ProductecaStrategy = require("passport-producteca").Strategy

exports.setup = (User, config) ->
  passport.use new ProductecaStrategy(
    config.producteca
  , (accessToken, _, profile, done) ->
    User.findOne { provider: "producteca", providerId: profile.id }, (err, user) ->
      return done err if err

      setTokenAndSave = =>
        user.tokens.producteca = accessToken
        user.save()
        user

      return done null, setTokenAndSave() if user?

      user = new User
        name: "#{profile.profile.firstName} #{profile.profile.lastName}"
        email: profile.email
        username: profile.credentials.username
        provider: "producteca"
        providerId: profile.id
        tokens:
          producteca: accessToken

      user.save (err) ->
        return done err if err
        done null, user
  )
