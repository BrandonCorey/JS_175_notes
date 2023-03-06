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
- `method` - Property that stores the method of the HTTP request
- `url` - Property that stores the path/request URI of the HTTP request

**`http.ServerReponse` instance methods**
- `statusCode` - Property that can be set for server response status code
- `setHeader` - Takes two arguments, a header field, and a header field-value. Can be used to set headers for HTTP response
- `write` - Takes a single string argument. Used to write to the HTTP body of the response
- `end` - Signals that the response headers and body have been set and reponse is ready to send. **Required** for all HTTP responses
- `writeHead` - Takes two arguments (actually more but not relevant). First of status code, second of object containing headers as key value pairs
  - Can be used to replace `res.statusCode and res.setHeader`

### `http.Server` instance methods ###
- `listen` - listens for incoming TCP connections
  - Takes two arguments, a port number, and an optional callback to be exeucted while it listens
  - This abtracts away the raw TCP data stream that we had to deal with while using netcat
  - As a result, instead of having to process the TCP data, we only have to worry about processing the HTTP request

```javascript
const HTTP = require('http'); // built in node module that contains classes to implement HTTP server
const PORT = 3000;  // ephemueral port for us to use for server to listen

const SERVER = HTTP.createServer((req, res) => {
  let method = req.method;
  let path = req.url;

  if (path === '/favicon.ico') {
    res.statusCode = 404;
    res.end();
  } else {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.write(`${method} ${path}`);
    res.end();
  }
});

SERVER.listen(PORT, () => {
  console.log(`Listening on port ${PORT}...`);
});
```
