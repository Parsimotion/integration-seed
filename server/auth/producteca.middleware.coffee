User = include("domain/schemas/user.model")
request = require("request-promise")
productecaOptions = include("config/environment").producteca

module.exports = (req, res, next) ->
  token = req.header("authorization")
  options =
    headers: Authorization: token
    json: true

  reject = -> res.status(401).send "Can't authenticate with Producteca. Check the 'Authorization' header."

  request.get(productecaOptions.profileUrl, options).then (body) ->
    User.findOneAsync(providerId: body.id).then (user) ->
      if not user? then throw "user not found"
      req.user = user
      req.token = token.replace "Bearer ", ""
      next()
  .catch reject
