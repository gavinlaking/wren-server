import "io" for File, Directory
import "meta" for Meta

import "lib/wren-json/json" for JSON

import "request" for Request
import "response" for Response

class StatusResource {
  construct index() {
    System.print("StatusResource called.")
  }
}

class TestResource {
  construct index() {
    System.print("TestResource called.")
  }
}

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

          Meta.eval(route["resource"])

          response.write()
        } else {
          // ignore non-matching route
        }
      }
    }
  }
}
