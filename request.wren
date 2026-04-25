import "io" for Stdin

import "./lib/Recto/Recto" for Recto
import "./parameters" for Parameters

class Request {
  body        { _requestBody }
  headers     { _requestHeaders }
  httpVersion { _requestHTTPVersion }
  method      { _requestMethod }
  params      { _requestParams }
  queryString { _requestQueryString }
  route       { method + " " + uri }
  uri         { _requestUri }

  construct new() {
    var str = Recto.new()

    var requestLine = Stdin.readLine()
    var requestAtoms = str.split(requestLine, " ")

    _requestMethod      = requestAtoms[0]
    _requestHTTPVersion = str.strip(requestAtoms[2])

    var uriAtoms = str.split(requestAtoms[1], "?")
    _requestUri         = uriAtoms[0]
    _requestQueryString = uriAtoms.count > 1 ? uriAtoms[1] : ""

    _requestHeaders = {}
    while (true) {
      var line = Stdin.readLine()
      if (line == null || line == "\r" || line == "") break
      var colonAt = line.indexOf(":")
      if (colonAt > 0) {
        var name  = str.lower(str.strip(line[0...colonAt]))
        var value = str.strip(line[(colonAt + 1)...line.count])
        _requestHeaders[name] = value
      }
    }

    _requestBody = ""
    var contentLength = _requestHeaders["content-length"]
    if (contentLength != null) {
      var length = Num.fromString(contentLength)
      if (length != null && length > 0) {
        var body = []
        for (i in 0...length) {
          var byte = Stdin.readByte()
          if (byte == -1) break
          body.add(str.toChr(byte))
        }
        _requestBody = body.join()
      }
    }

    _requestParams = Parameters.new(_requestBody, _requestHeaders["content-type"])
  }
}
