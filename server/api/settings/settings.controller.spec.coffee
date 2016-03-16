Promise = require("bluebird")
require("chai").should()
selfRequest = include("specHelpers/selfRequest")

config = include("config/environment")

describe "SettingsController", ->
  beforeEach ->
    config.producteca.uri = "http://urlDeProducteca.com"

  it "returns the api url based on the config", ->
    selfRequest.get("/api/settings/env").then ({ body }) ->
      body.should.eql apiUrl: "http://urlDeProducteca.com"
