import "status" for Status

class Response {
  statusCode { _statusCode }
  messageBody { _messageBody }

  construct new(statusCode, messageBody) {}

  body() {
    if (messageBody) {
      System.print(messageBody)
    } else {
      System.print("")
    }
  }

  header() {
    var status = Status.new(statusCode)
    System.print("HTTP/1.1 " + status.print() + "\n")
  }

  write() {
    header()
    body()
  }
}
