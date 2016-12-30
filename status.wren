class Status {
  codes { {
    "200": "OK",
    "201": "Created",
    "202": "Accepted",
    "204": "No Content",
    "301": "Moved Permanently",
    "302": "Found",
    "304": "Not Modified",
    "307": "Temporary Redirect",
    "308": "Permanent Redirect",
    "400": "Bad Request",
    "401": "Unauthorized",
    "403": "Forbidden",
    "404": "Not Found",
    "406": "Not Acceptable",
    "408": "Request Time-out",
    "410": "Gone",
    "415": "Unsupported Media Type",
    "422": "Unprocessable Entity",
    "429": "Too Many Requests",
    "500": "Internal Server Error",
    "501": "Not Implemented",
    "502": "Bad Gateway",
    "503": "Service Unavailable",
    "504": "Gateway Time-out"
  } }

  construct new(statusCode) {
    _statusCode = statusCode
  }

  print() {
    if (this.codes.containsKey(_statusCode)) {
      return _statusCode + " " + this.codes[_statusCode] + "\r\n"
    } else {
      return "500 Internal Server Error\r\n"
    }
  }
}
