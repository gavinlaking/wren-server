import "io" for Stdin

import "lib/Recto/Recto" for Recto

import "request" for Request
import "response" for Response
import "status" for Status

class Server {
  buffer { "" }
  buffer=(newBuffer) { buffer = buffer + newBuffer }

  construct new() {
    var crlf           = 0
    var requestHeaders = []
    var str            = Recto.new()

    while(crlf < 3) {
      var line = Stdin.readLine()
      requestHeaders.add(line)
      if (line.contains("\r")) { crlf = crlf + 1 }
    }

    var requestLine = requestHeaders.removeAt(0)

    var request            = str.split(requestLine, " ")
    var requestMethod      = request[0]
    var requestUri         = request[1]
    var requestHTTPVersion = request[2]

    respond()
  }

  respond() {
    var statusCode = "200"
    var messageBody = "Hello World!"

    var response = Response.new(statusCode, messageBody)
    response.write()
  }
}

var server = Server.new()
