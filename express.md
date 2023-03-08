## `express` framework ##
Used to make backend development a lot easier

### Overview ###
The value returned by importing the `express` module is a function we must call to create an application object
```javascript
const express = require('express');
const app = express();
```

We can create a **route** that handles HTTP `GET` requests using `get` method
- Can specify URL path as first argument, then a callback that takes arguments of request and response objects as second
- This callback will be executed whenever an HTTP `GET` request is recieved for the `/` path
  - Can use `send` to pass argument for HTTP body and send response
  - Can use `render` to render a page view from a templating engine and send a reponse
- The argument to the `get` method is typically referred to as a **route handler** or **route controller**
```javascript
app.get('/', (req, res) => {
  res.send('<h1>Hello world</h1>')
});
```
```javascript
app.get("/", (req, res) => {
  res.render("hello_world");
});
```

We can set our view engine and our `views` directory using `app.set`
```javascript
app.set("views", "./views");
app.set("view engine", "pug");
```

Can listen using the `listen` method:
```javascript
app.listen(3000, "localhost", () => {
  console.log("Listening to port 3000.");
});
```
