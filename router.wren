import "io" for File, Directory
import "meta" for Meta

import "./request" for Request
import "./response" for Response
import "./routes" for Routes

class StatusResource {
  static index() {
    return "Hello World!"
  }
}

class TestResource {
  static index() {
    return "TestResource.index() called."
  }

  static create() {
    return "TestResource.create() called."
  }

  static newForm() {
    return "TestResource.newForm() called."
  }

  static edit() {
    return "TestResource.edit() called."
  }

  static update() {
    return "TestResource.update() called."
  }

  static destroy() {
    return "TestResource.destroy() called."
  }
}

class Router {
  construct new() {
    var request = Request.new()
    var resource = Routes.resources(request.route)

    var statusCode
    var messageBody

    if (resource) {
      var function = Meta.compileExpression(resource)
      if (function == null) {
        statusCode = "500"
        messageBody = "Invalid resource: '" + resource + "'"
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
    } else {
      statusCode = "404"
      messageBody = "Not Found"
    }

    var response = Response.new(statusCode, messageBody)
    response.write()
  }
}
