module.exports = (router) ->

  endpointHandler = (action) =>
    (req, res, next) =>

      respond = (body) =>
        if not res._headerSent then res.send body

      handleError = (err) =>
        logStack = (err) =>
          console.log err.stack if err.stack?

        if err.statusCode?
          res.status(err.statusCode).send err.body
          logStack err
        else
          res.status(500).send err
          logStack err

      result = null
      try
        result = action req, res, next
      catch err
        return handleError err

      result?.then? respond
      .catch? handleError

  route = (verb, path, middlewares...) ->
    lastIndex = middlewares.length - 1
    middlewares[lastIndex] = endpointHandler middlewares[lastIndex]
    router[verb].apply router, [path].concat middlewares

  { endpointHandler, route }
