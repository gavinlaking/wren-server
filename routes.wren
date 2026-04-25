class Routes {
  static resources(route) {
    return {
      "GET /":            "StatusResource.index()",
      "GET /test":        "TestResource.index()",
      "POST /test":       "TestResource.create()",
      "GET /test/new":    "TestResource.newForm()",
      "GET /test/1/edit": "TestResource.edit()",
      "PATCH /test/1":    "TestResource.update()",
      "DELETE /test/1":   "TestResource.destroy()",
    }[route]
  }
}

