_ = require("lodash")

exports.get = (req, res) ->
  res.send req.user.settings

exports.update = (req, res) ->
  _.assign req.user.settings, req.body
  req.user.saveAsync()
