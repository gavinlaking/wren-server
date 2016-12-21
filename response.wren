import "status" for Status

class Response {
  construct new(statusCode, messageBody) {
    _statusCode = statusCode
    _messageBody = messageBody
  }

  body() {
    if (_messageBody) {
      return _messageBody
    } else {
      return ""
    }
  }

  bodySize() {
    return body().count.toString
  }

  headers() {
    return statusLine + date + expires + server + type + length
  }

  write() {
    System.print(headers())
    System.print(body())
  }

  statusLine { "HTTP/1.0 " + Status.new(_statusCode).print() }
  date       { "Date: \r\n" }
  expires    { "Expires: \r\n" }
  server     { "Server: wren-server\r\n" }
  type       { "Content-Type: text/plain\r\n" }
  length     { "Content-Length: " + bodySize() + "\r\n" }
}

