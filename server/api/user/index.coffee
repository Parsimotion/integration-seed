express = require("express")
controller = require("./user.controller")
auth = include("auth/auth.service")
router = express.Router()
{ route } = include("api/endpointHandler") router

router.use auth.authenticated

route.get "/me", controller.me

module.exports = router
