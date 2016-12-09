import "io" for Stdin
import "request" for Request
import "response" for Response
import "status" for Status

class Buffer {
  buffer { _newBuffer }
  buffer=(newBuffer) { }

  construct new(newBuffer) {
  }
}

class Server {
  buffer { "" }
  buffer=(newBuffer) { buffer = buffer + newBuffer }

  construct new() {
    while(true) {
      while(this.buffer.count <= 1024) {
        var line = Stdin.readLine()
        if (line.count <= 1024) {
          this.buffer = buffer + line
        } else {

        }
      }
      System.print(buffer)

      respond()
    }
  }

  respond() {
    var statusCode = "200"
    var messageBody = "Hello World!"

    var response = Response.new(statusCode, messageBody)
    response.write()
  }
}

var server = Server.new()
