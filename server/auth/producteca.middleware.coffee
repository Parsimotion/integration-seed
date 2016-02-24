User = include("domain/schemas/user.model")
request = require("request-promise")
productecaOptions = include("config/environment").producteca

module.exports = (req, res, next) ->
  options =
    headers: Authorization: req.header("authorization")
    json: true

  reject = -> res.status(401).send "Can't authenticate with Producteca. Check the 'Authorization' header."

  request.get(productecaOptions.profileUrl, options).then (body) ->
    User.findOneAsync(providerId: body.id).then (user) ->
      if not user? then throw "user not found"
      req.user = user
      req.token = token
      next()
  .catch reject
