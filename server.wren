import "request" for Request
import "response" for Response
import "status" for Status

class Server {
  construct new() {
    var request = Request.new()

    var response = Response.new(request.statusCode, request.messageBody)
    response.write()
  }
}

var server = Server.new()
