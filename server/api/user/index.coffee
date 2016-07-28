express = require("express")
controller = require("./assignedproducts.controller")
auth = include("auth/auth.service")
router = express.Router()
{ route } = include("api/endpointHandler") router

route.get "/me", auth.authenticated, controller.me

module.exports = router
