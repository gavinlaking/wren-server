import "io" for File, Directory
import "lib/wren-json/json" for JSON

import "request" for Request
import "response" for Response

class Router {
  construct new() {
    var request = Request.new()
    var response = Response.new(request.statusCode, request.messageBody)

    var routesFile = "../routes.json"
    var requestStr = request.method + " " + request.uri

    if (File.exists(routesFile)) {
      var file = File.read(routesFile)
      var routes = JSON.parse(file)

      for (route in routes) {
        if (requestStr == route["request"]) {
          System.print("Route matches: " + requestStr)
          response.write()
        } else {
          // ignore non-matching route
        }
      }
    }
  }
}
