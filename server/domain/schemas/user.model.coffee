{ Types, create } = require("./schemaFactory")

module.exports = create
  name: "User"

  properties:
    name: String
    email:
      type: String
      lowercase: true
      required: true
      unique: true

    provider: String
    providerId: Number

    tokens:
      producteca: String

    settings:
      saved: Boolean

  addToJSON: false
