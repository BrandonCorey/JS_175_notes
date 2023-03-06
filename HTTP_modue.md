# Node HTTP module #
There is a node HTTP module that contains classes used to implement an HTTP server
- Can be imported by requiring `http`

## `createServer` method ##
Node's `http` module has a `createServer` method that returns a new instance of the `http.Server` class
- It is typically called with a single argument, a callback function

### Callback argument of `createServer` ###
- The callback is execute each time a new HTTP request is recieved by the new instance of `http.Server`
  - This callback takes two arguments, an `IncomingMessage` object, and a `ServerResponse` object
  - These two objects are typically represented by the parameters `req` and `res`
  - Each time a request is recieved, our new instance of http.Server passes an instance of `http.IncomingMessage` and `httpServerReponse` to this callback

### Important props/ methods for `req` and `res` objects ###
**`http.IncomingMessage` instance methods**
- `req.method` - Property that stores the method of the HTTP request
- `req.url` - Property that stores the path/request URI of the HTTP request

**`http.ServerReponse` instance methods**
- `res.statusCode` - Property that can be set for server response status code
- `res.setHeader` - Takes two arguments, a header field, and a header field-value. Can be used to set headers for HTTP response
- `res.write` - Takes a single string argument. Used to write to the HTTP body of the response
- `res.end` - Signals that the response headers and body have been set and reponse is ready to send. **Required** for all HTTP responses
- `res.writeHead` - Takes two arguments (actually more but not relevant). First of status code, second of object containing headers as key value pairs
  - Can be used to replace `res.statusCode and res.setHeader`
