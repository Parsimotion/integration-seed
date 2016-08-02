{ Types, create } = require("./schemaFactory")

module.exports = create
  name: "User"

  properties:
    _id: Number

    name: String
    email:
      type: String
      lowercase: true
      required: true
      unique: true

    tokens:
      producteca: String

  addToJSON: true
