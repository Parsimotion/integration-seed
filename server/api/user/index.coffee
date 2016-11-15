express = require("express")
controller = require("./user.controller")
auth = include("auth/auth.service")
router = express.Router()
{ route } = require("endpoint-handler") router

router.use auth.authenticated

route.get "/me", controller.me

module.exports = router
