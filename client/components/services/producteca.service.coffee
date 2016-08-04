app.factory "Producteca", ($resource, PRODUCTECA_API) ->
  envResource = $resource "/api/settings/env", { }

  (token) ->
    setAuthorizationHeader = (data, headersGetter) -> headersGetter().Authorization = "Bearer #{token}"

    $resource PRODUCTECA_API, {},
      user:
        method: "GET"
        url: "#{PRODUCTECA_API}/users/me"
        transformRequest: setAuthorizationHeader
