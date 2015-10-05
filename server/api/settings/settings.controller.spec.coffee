Promise = require("bluebird")
should = require("chai").should()
request = Promise.promisifyAll require("supertest")
app = include("app").app
config = include("config/environment")

describe "SettingsController", ->
  beforeEach ->
    config.producteca.uri = "http://urlDeProducteca.com"

  it "returns the api url based on the config", ->
    request(app)
      .get("/api/settings/env")
      .expect 200
      .endAsync().then ({ body }) ->
        body.should.eql apiUrl: "http://urlDeProducteca.com"
