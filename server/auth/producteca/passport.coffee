passport = require("passport")
ProductecaStrategy = require("passport-producteca").Strategy

exports.setup = (User, config) ->
  passport.use new ProductecaStrategy(
    config.producteca
  , (accessToken, _, profile, done) ->
    User.findById profile.company.id, (err, user) ->
      return done err if err

      setTokenAndSave = =>
        user.tokens.producteca = accessToken
        user.save()
        user

      return done null, setTokenAndSave() if user?

      user = new User
        _id: profile.company.id
        name: "#{profile.profile.firstName} #{profile.profile.lastName}"
        email: profile.email
        username: profile.credentials.username
        tokens:
          producteca: accessToken

      user.save (err) ->
        return done err if err
        done null, user
  )
