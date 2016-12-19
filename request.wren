import "io" for Stdin

import "lib/Recto/Recto" for Recto

class Request {
  requestMethod { _requestMethod }
  requestUri { _requestUri }
  requestHTTPVersion { _requestHTTPVersion }
  requestHeaders { _requestHeaders }
  statusCode { _statusCode }
  messageBody { _messageBody }

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
    var request     = str.split(requestLine, " ")

    _requestMethod = request[0]
    _requestUri = request[1]
    _requestHTTPVersion = request[2]

    // TODO: Set the HTTP status code for the response;
    // e.g. 200 if we can serve the request.
    _statusCode = "200"
    _messageBody = "Hello World!"
  }

  delete() {}
  get() {}
  patch() {}
  post() {}
}
