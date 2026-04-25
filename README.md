# wren-server

A minimal HTTP server written in [Wren](https://github.com/munificent/wren).

## Dependencies

- [wren_cli](https://github.com/wren-lang/wren-cli) 0.4.0
- Brian Otto's [Recto](https://github.com/BrianOtto/Recto) string library (included in `lib/Recto/`)

System packages:

```sh
sudo apt-get install netcat      # for bin/wren-server (single-connection mode)
sudo apt-get install ucspi-tcp   # for bin/wren-tcpserver (concurrent mode)
```

## Running the server

Two server modes are provided in `bin/`:

**Single-connection** (one request at a time, useful for development):

```sh
bin/wren-server
```

Uses a named pipe and `netcat` to loop indefinitely, handling one connection before accepting the next. All raw traffic is logged to `log/inflow` and `log/outflow`.

**Concurrent** (spawns a new process per connection):

```sh
bin/wren-tcpserver
```

Uses `tcpserver` from `ucspi-tcp` to accept multiple simultaneous connections.

Both modes listen on port **8080**.

## How it works

Each incoming HTTP request is piped to a fresh `wren_cli server.wren` process via stdin. The pipeline is:

```
Request → request.wren → router.wren → routes.wren → resource method → response.wren → Response
```

1. **`request.wren`** reads the request line and headers from stdin (terminating at the blank line), parses headers into a map, then reads the body up to `Content-Length` bytes using `Stdin.readByte()`. It exposes `method`, `uri`, `route`, `headers`, `queryString`, `body`, and `params`.

2. **`parameters.wren`** parses an `application/x-www-form-urlencoded` body into key/value pairs, with full URL decoding (`+` → space, `%XX` → character). Access via `params.get("key")` or `params.all`.

3. **`routes.wren`** maps route strings (e.g. `"POST /test"`) to resource method expressions (e.g. `"TestResource.create()"`).

4. **`router.wren`** looks up the route, uses `Meta.compileExpression()` to evaluate the resource method string, runs it in a `Fiber` to catch errors, and responds with 200, 404, or 500 accordingly.

5. **`response.wren`** builds and writes the HTTP/1.0 response with status, headers, and body.

## Current routes

| Method | Path          | Handler                    |
|--------|---------------|----------------------------|
| GET    | `/`           | `StatusResource.index()`   |
| GET    | `/test`       | `TestResource.index()`     |
| POST   | `/test`       | `TestResource.create()`    |
| GET    | `/test/new`   | `TestResource.newForm()`   |
| GET    | `/test/1/edit`| `TestResource.edit()`      |
| PATCH  | `/test/1`     | `TestResource.update()`    |
| DELETE | `/test/1`     | `TestResource.destroy()`   |

Route IDs are currently hardcoded. Dynamic segment matching (`:id`) is not yet implemented.

## Adding routes

Add an entry to the map in `routes.wren` and a corresponding static method on a resource class in `router.wren`:

```
// routes.wren
"GET /widgets": "WidgetResource.index()",

// router.wren
class WidgetResource {
  static index() {
    return "list of widgets"
  }
}
```

## Testing

```sh
# Fire repeated POST requests
test/curler

# Load test with siege
test/bencher
```
