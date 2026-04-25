import "./lib/Recto/Recto" for Recto

class Parameters {
  all      { _params }
  get(key) { _params[key] }

  construct new(body, contentType) {
    _params = {}

    if (contentType == null || body == null || body.count == 0) return

    if (contentType.contains("application/x-www-form-urlencoded")) {
      var str = Recto.new()
      for (pair in str.split(body, "&")) {
        var eqAt = pair.indexOf("=")
        if (eqAt >= 0) {
          var key = urlDecode(pair[0...eqAt])
          var val = urlDecode(pair[(eqAt + 1)...pair.count])
          _params[key] = val
        } else {
          _params[urlDecode(pair)] = ""
        }
      }
    }
  }

  hexVal(chr) {
    var ord = chr.bytes[0]
    if (ord >= 48 && ord <= 57)  return ord - 48
    if (ord >= 65 && ord <= 70)  return ord - 55
    if (ord >= 97 && ord <= 102) return ord - 87
    return 0
  }

  urlDecode(str) {
    var recto = Recto.new()
    var result = ""
    var i = 0
    while (i < str.count) {
      var ch = str[i]
      if (ch == "+") {
        result = result + " "
      } else if (ch == "\x25" && i + 2 < str.count) {
        result = result + recto.toChr(hexVal(str[i + 1]) * 16 + hexVal(str[i + 2]))
        i = i + 2
      } else {
        result = result + ch
      }
      i = i + 1
    }
    return result
  }
}
