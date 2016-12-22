import "io" for File, Directory
import "meta" for Meta

import "lib/wren-json/json" for JSON

import "request" for Request
import "response" for Response

class StatusResource {
  construct index() {
    return "Hello World!"
  }
}

class TestResource {
  construct index() {
    return "TestResource.index() called."
  }

  construct create() {
    return "TestResource.create() called."
  }

  construct new() {
    return "TestResource.new() called."
  }

  construct edit() {
    return "TestResource.edit() called."
  }

  construct update() {
    return "TestResource.update() called."
  }

  construct destroy() {
    return "TestResource.destroy() called."
  }
}

class Router {
  construct new() {
    var request = Request.new()

    var routesFile = "../routes.json"
    var requestStr = request.method + " " + request.uri

    if (File.exists(routesFile)) {
      var file = File.read(routesFile)
      var routes = JSON.parse(file)
      var statusCode
      var messageBody

      for (route in routes) {
        if (requestStr == route["request"]) {
          var function = Meta.compileExpression(route["resource"])
          if (function == null) {
            statusCode = "500"
            messageBody = "Invalid resource: '" + route["resource"] + "'"
          }

          var fiber = Fiber.new(function)
          var result = fiber.try()
          if (fiber.error == null) {
            statusCode = "200"
            messageBody = result
          } else {
            statusCode = "500"
            messageBody = fiber.error.toString
          }

          break

        } else {
          // ignore non-matching routes
        }
      }

      var response = Response.new(statusCode, messageBody)
      response.write()
    }
  }
}
