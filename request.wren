import "io" for Stdin

import "lib/Recto/Recto" for Recto

class Request {
  method { _requestMethod }
  uri { _requestUri }
  queryString { _requestQueryString }
  requestHTTPVersion { _requestHTTPVersion }
  requestHeaders { _requestHeaders }

  construct new() {
    var crlf = 0
    _requestHeaders = []
    var str = Recto.new()

    while(crlf < 3) {
      var line = Stdin.readLine()
      _requestHeaders.add(line)
      if (line.contains("\r")) { crlf = crlf + 1 }
    }

    var requestLine = _requestHeaders.removeAt(0)
    var requestAtoms = str.split(requestLine, " ")

    _requestMethod = requestAtoms[0]
    _requestHTTPVersion = requestAtoms[2]

    var requestUriAtoms = str.split(requestAtoms[1], "?")
    _requestUri = requestUriAtoms[0]

    if (requestUriAtoms.count > 1) {
      _requestQueryString = requestUriAtoms[1]
    }
  }
}
