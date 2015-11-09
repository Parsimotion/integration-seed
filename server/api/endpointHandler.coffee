module.exports = (router) ->

  endpointHandler = (action) =>
    (req, res, next) =>

      respond = (body) =>
        if not res._headerSent then res.send body

      logStack = (err) =>
        console.log err.stack if err.stack?

      allIsBroken = (err) =>
        res.status(500).send err
        logStack err

      result = action(req, res, next)
      result?.then? respond
      .catch? (err) =>
        if err.statusCode?
          res.status(err.statusCode).send err.body
          logStack err
        else allIsBroken err

  route = (verb, path, middlewares...) ->
    lastIndex = middlewares.length - 1
    middlewares[lastIndex] = endpointHandler middlewares[lastIndex]
    router[verb].apply router, [path].concat middlewares

  { endpointHandler, route }

