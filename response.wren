import "status" for Status

class Response {
  statusCode { _statusCode }
  messageBody { _messageBody }
  serverName { "wren-server" }
  httpVersion { "HTTP/1.0" }

  construct new(statusCode, messageBody) {
    _statusCode = statusCode
    _messageBody = messageBody
  }

  body() {
    if (messageBody) {
      return messageBody
    } else {
      return ""
    }
  }

  bodySize() {
    return body().count.toString
  }

  headers() {
    var status  = Status.new(statusCode)
    var date    = "Date: "           + "\r\n"
    var expires = "Expires: "        + "\r\n"
    var server  = "Server: "         + serverName + "\r\n"
    var type    = "Content-Type: "   + "text/plain\r\n"
    var length  = "Content-Length: " + bodySize() + "\r\n"

    return httpVersion +
           status.print() +
           date +
           expires +
           server +
           type +
           length
  }

  write() {
    System.print(headers())
    System.print(body())
  }
}
