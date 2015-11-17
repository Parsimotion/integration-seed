_ = require("lodash")
expect = require("chai").expect
clean = (it) -> JSON.stringify it

havePropertiesEqual = (oldObject, newObject) ->
  return oldObject is newObject if (not oldObject? or not newObject?)

  keys = _.keys newObject

  _.every keys, (key) ->
    value = newObject[key]

    if _.isPlainObject(value) or _.isArray(value)
      return havePropertiesEqual oldObject[key], value

    expect(clean oldObject[key]).to.eql clean(value)

module.exports = havePropertiesEqual
