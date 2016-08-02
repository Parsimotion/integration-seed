should = require("should")
User = require("./user.model")
user = new User(
  _id: 1
  provider: "producteca"
  name: "Fake User"
  email: "test@test.com"
)
_ = require("lodash")
ValidationError = require("mongoose").Error.ValidationError

describe "User Model", ->
  it "should store the producteca id", ->
    new User(
      _id: 999
      email: 'juanpablo@gmail.com'
    ).saveAsync().then ->
      User.findByIdAsync(_id: 999).then (user) ->
        should.exist user

  it "should fail when saving a duplicate user", (done) ->
    user.saveAsync()
    .then ->
      userDup = new User(email: "test@test.com", _id: 2)
      userDup
      .saveAsync()
      .catch (e) -> done()

  it "should fail when saving without an email", (done) ->
    user.email = ""
    user.saveAsync()
    .catch (ValidationError, e) -> done()
