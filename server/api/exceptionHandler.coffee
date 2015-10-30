module.exports = (router) ->

  exceptionHandler = (action) =>
    (req, res, next) =>
      action(req, res, next)?.catch? (err) =>
        if err.statusCode?
          res.status(err.statusCode).send err.body
        else if err.message?
          res.status(500).send err.message
        else
          console.log err
          res.status(500).send err

  route = (verb, path, middlewares...) ->
    lastIndex = middlewares.length - 1
    middlewares[lastIndex] = exceptionHandler middlewares[lastIndex]
    router[verb].apply router, [path].concat middlewares

  { exceptionHandler, route }
