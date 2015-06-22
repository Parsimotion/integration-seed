ColppyApi = require("./colppyApi")
SDK = require("producteca-sdk")
ProductecaApi = SDK.Api
Adjustment = SDK.Sync.Adjustment
Syncer = SDK.Sync.Syncer
config = require("../config/environment")
_ = require("lodash")

module.exports =

class ProductsSyncer
  constructor: (@user, @settings)->
    @colppyApi = new ColppyApi config.colppy
    @productecaApi = new ProductecaApi
      accessToken: @user.tokens.parsimotion
      url: config.parsimotion.uri
    accessToken: config.parsimotion.uri

  sync: =>
    @getAdjustments().then (adjustments) =>
        console.log "✔ adjustments."

        @productecaApi.getProducts().then (products) =>
          console.log "✔ products."

          new Syncer(@productecaApi, @settings, products)
            .execute(adjustments).then (results) =>
              console.log "✔ sync."
              console.log JSON.stringify results
    .catch (error) =>
      console.error "✘ something went wrong:"
      console.error JSON.stringify error

  getAdjustments: =>
    @colppyApi.login(@user.tokens.colppy).then =>
      @colppyApi.getLastCompany().then (company) =>
        @colppyApi.getProducts(company).then (products) =>
          products.map (it) => new Adjustment
            identifier: it.codigo
            name: it.descripcion
            price: it.precioVenta.replace ",", "."
            stock: it.disponibilidad