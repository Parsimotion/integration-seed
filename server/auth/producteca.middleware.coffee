Promise = require("bluebird")
User = include("api/user/user.model")
request = Promise.promisifyAll require("request")
productecaOptions = include("config/environment").producteca

module.exports = (req, res, next) ->
  options =
    headers: Authorization: req.header("authorization")
    json: true

  reject = -> res.status(401).send "Can't authenticate with Producteca. Check the 'Authorization' header."

  request.getAsync(productecaOptions.profileUrl, options)
    .spread ({ statusCode, body }) ->
      return reject() if statusCode isnt 200

      User.findOneAsync(providerId: body.id).then (user) ->
        if not user? then throw "user not found"
        req.user = user
        next()
    .catch reject
