module.exports = (req, res) ->
  res.writeHead 200,
    "Content-Type": "application/javascript"

  constants = [
    key: "ACCESS_TOKEN"
    value: req.user.tokens.producteca
  ,
    key: "PRODUCTECA_API"
    value: process.env.PRODUCTECA_API or "http://api.producteca.com"
  ].map((it) ->
    "app.constant('" + it.key + "', '" + it.value + "');"
  ).join("\n")

  res.end constants
