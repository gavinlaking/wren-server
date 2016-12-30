import "lib/Recto/Recto" for Recto

class Parameters {
  parameters { _parameters }

  construct new(queryString) {
    _queryString = queryString

    var str = Recto.new()
    var pairs = str.split(queryString, "&")

    _parameters = {}

    for(pair in pairs) {
      var keyValue = str.split(pair, "=")
      _parameters[keyValue[0]] = keyValue[1]
    }
  }

  inspect() {
    for(param in parameters.keys) {
      System.print("Key: " + param + " Value: " + parameters[param])
    }
  }
}
