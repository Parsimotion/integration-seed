should = require("chai").should()
User = require("./user.model")
user = new User(
  provider: "producteca"
  name: "Fake User"
  email: "test@test.com"
)
_ = require("lodash")
ValidationError = require("mongoose").Error.ValidationError

describe "User Model", ->
  it "should store the provider and its id", ->
    new User(
      email: 'juanpablo@gmail.com'
      provider: 'producteca'
      providerId: 999
    ).saveAsync().then ->
      User.findOneAsync(providerId: 999).then (user) ->
        user.should.have.property "provider", "producteca"
        user.should.have.property "providerId", 999

  it "should fail when saving a duplicate user", (done) ->
    user.saveAsync()
    .then ->
      userDup = new User(email: "test@test.com")
      userDup
      .saveAsync()
      .catch (e) -> done()

  it "should fail when saving without an email", (done) ->
    user.email = ""
    user.saveAsync()
    .catch (ValidationError, e) -> done()
