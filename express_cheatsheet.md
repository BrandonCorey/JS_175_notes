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
  - has 3 arguments
  - `req`, `res`, and `next` (the standard names for these parameters
  - `req` and `res` are request and response objects
  - `next` - argument used for middleware function exeution
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

## Static assets
Most web pages will need some type of static assets like images, stylesheets, fonts, client side JS etc.
- Keep these in a `public` directory on server
  - e.g `mkdir public` `mkdir public/stylesheets`
- Can use built in express function `express.static` to return a middleware function for `app` to use
  - `static` takes an argument for the name of the directory containing the static assets
  - The returned function will return assets whenever the path includes a subdirectory inside of `public`

```javascript
app.use(express.static("public"));
```

## Logging
Can use the `morgan` module to log our HTTP requests, which is a standard practice in web development
- Requiring imports a function that takes an argument to specify the style of log
- common: `127.0.0.1 - - [26/Oct/2019:23:48:48 +0000] "GET /english HTTP/1.1" 200 823`
-----------ip address------time UTC---------------------request line--------status---length (bits)

```javascript
const morgan = require("morgan");
app.use(morgan('common');
```
## Paremtized routes
Named URL segments that are used to capture the values specified at their position in the URL
- denote with colon (`:`)
- denoted parameters are automatically added to `params` object for `req`
- Useful for dynamically routing requests based on path
- You can name these parameters anything, but they should describe the general structure of the URL
  - values for each parameter will be used as values for prop in `param` object

```
GET /banking/bnk/brandoncorey/bc711f HTTP/1.1
```
```javascript
app.get('/account/:accountId/users/:userId', (req, res) => {
  const { userId, accountId } = req.params;
  res.render('account_page', {
    userId,
    accountId
  ])
  console.log(req.params) // => { accountId: 'bnk', userId: 'bc711f' }
});
```

## error handler middleware
In Express, error handling middleware functions are executed in the order they are defined, but they have a special signature that includes an err parameter as the first parameter. This allows them to handle errors that are passed to the next function by previous middleware functions.
- Unike other middleware, error handler are defined after the routes and will execute if any error is encountered in the request processing pipeline

If an error occurs in any middleware function or route handler, the next function should be called with an error object as its first parameter, like this:
```javascript
app.get('/example', function(req, res, next) {
  // Some code that may throw an error
  throw new Error('Something went wrong');
});

// Error handling middleware function
app.use(function(err, req, res, next) {
  console.log('Error occurred:', err.message);
  res.status(500).send('Internal server error');
});

```
