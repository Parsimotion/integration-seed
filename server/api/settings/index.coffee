express = require("express")
controller = require("./settings.controller")
auth = include("auth/auth.service")
router = express.Router()
{ route } = include("api/endpointHandler") router

router.use auth.authenticated

route.get "/", controller.get
route.put "/", controller.update

module.exports = router
