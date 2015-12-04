# Development specific configuration
# ==================================
module.exports =

  # MongoDB connection options
  mongo:
    uri: process.env.MONGO_URI || "mongodb://localhost/integration-seed-dev"
