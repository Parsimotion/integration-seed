_ = require("lodash")

module.exports = (router) ->

  endpointHandler = (action) =>
    (req, res, next) =>

      respond = (body) =>
        if not res._headerSent then res.send body

      handleError = (err) =>
        console.log err.stack if err.stack?
        if res._headersSent then return

        if err.statusCode?
          res.status(err.statusCode).send err.body
        else
          res.status(500).send err

      result = null
      try
        result = action req, res, next
      catch err
        return handleError err

      result?
      .catch? handleError
      .then? respond

  route = (verb, path, middlewares...) ->
    lastIndex = middlewares.length - 1
    middlewares[lastIndex] = endpointHandler middlewares[lastIndex]
    router[verb].apply router, [path].concat middlewares

  verbs =
    _(["get", "post", "put", "delete"])
      .keyBy()
      .mapValues (verb) -> _.partial route, verb
      .value()

  _.merge { endpointHandler }, route: verbs
