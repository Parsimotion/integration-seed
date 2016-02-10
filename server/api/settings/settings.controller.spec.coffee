Promise = require("bluebird")
require("chai").should()
requestApp = include("specHelpers/requestApp")

config = include("config/environment")

describe "SettingsController", ->
  beforeEach ->
    config.producteca.uri = "http://urlDeProducteca.com"

  it "returns the api url based on the config", ->
    requestApp("get", "/api/settings/env").then ({ body }) ->
      body.should.eql apiUrl: "http://urlDeProducteca.com"
