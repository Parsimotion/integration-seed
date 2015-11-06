module.exports = (router) ->

  endpointHandler = (action) =>
    (req, res, next) =>

      respond = (body) =>
        if not res._headerSent then res.send body

      allIsBroken = (err) =>
        console.log err.stack
        res.status(500).send err
        throw err

      try
        action(req, res, next)
          .then? respond
          .catch? (err) =>
            if err.statusCode?
              res.status(err.statusCode).send err.body
              throw err
            else allIsBroken err
      catch err
        allIsBroken err

  route = (verb, path, middlewares...) ->
    lastIndex = middlewares.length - 1
    middlewares[lastIndex] = endpointHandler middlewares[lastIndex]
    router[verb].apply router, [path].concat middlewares

  { endpointHandler, route }
