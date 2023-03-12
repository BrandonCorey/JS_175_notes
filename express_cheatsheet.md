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
## Paremetized routes
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
## handling `POST` requests
`POST` requests send data to the server, one of the common ways of doing this is through the use of a form
- A form allows a user on the client-side to send data the the server
- We need to use `express.urlencoded` to return a middleware function that parses the request body and stores the responses in `req.body` body
  - Takes argument of `{extended: false}` objece, the true/false just specifies which module to use for parsing (qs vs querystring, not important, use false)
  - If this middleware is not set up, req.body will be undefined, so remember to do this
- We can then access the data from the form within `req.body`
  - The properties will be the `name` attributes specified in the form, and the values will be the values that were **submitted**
```javascript
app.use(express.urlencoded({ extended: false })); 
```
```javascript
app.post('/contacts/new', (req, res) => {
  console.log(req.body); // ==> { firstName: 'Brandon', lastName: 'Corey', phoneNumber: '123-456-8910' }
  contactData.push({...req.body}); // spread so we make a copy of the body object of the request

  res.redirect('/contacts');
});
```
```pug
label(for='firstName') First Name:
input(type='text' name='firstName' id='firstName')
label(for='lastName') Last Name;
input(type='text' name='lastName' id='lastName')
```
## Middleware
**Express middleware functions are callback functions used by Express methods like `app.use` and `app.get`**, among others. These functions can access and manipulate the request and response objects per the application requirements
- Middleware functions usually have parameters for `req, res, next` with `next` being optional
- Route handlers/controllers are middleware
- `next` can be invoked to tell express to execute **the next middleware that matches the request conditions**
### Structure ###
**Middleware must either generate an HTTP response or tell Express to execute the next middleware**. You can use calls like render, send, and redirect to generate a response; you can call the next function to execute the next middleware
- express calls middleware in the order in which they are defined
- Can be executed at **application level** (for all requests) by passing middleware function to `app.use`
  - Can also be used for **all requests of a specific path**
- Can be executed at the **route level** (for requests of a certain URL and Method by passing middleware function to `app.get`, `app.post` etc..
- **`app.use`, `app.get`, `app.post` (any request method) allow you to add successive middleware functions as additional arguments (comma or array) as well**
```javascript
app.use((req, res, next) => {      // Middleware #1
  // do something
  if (somethingIsTrue) res.render("foo");
  else next();
});

app.use((req, res, next) => {      // Middleware #2
  // do something else
  next();
});

app.get("/stuff", (req, res) => {  // Middleware #3
  res.render("qux");
});
```
```javascript
app.use((req, res, next) => {      // Middleware #1
  // do something
  if (somethingIsTrue) res.render("foo");
  else next();
  },
  (req, res, next) => {           // Middleware #2
    // do something else
    next();
  },
);
```
```javascript
const middleware1 = (req, res, next) => {
  // do something
  if (somethingIsTrue) res.render("foo");
  else next();
  }
};

const middleware2 = (req, res, next) => {
  // do something else
  next();
};

app.use(middleware1, middleware2);
```

### Passing data between midldleware
One of the easiest ways to do this is by storing data with `res.locals`
- This stores data within the `res.locals` object for the duration of the specific HTTP request/respose cycle
  - This is different from `app.locals`, which stores data for the lifetime of the application process
- This data can be accessed by all other middleware **that match the request conditions**
- Similar to `app.locals`, `res.locals` variables are available within our `views`, **BUT should still** explicitly be passed through an object
```javascript
app.get(
  "/foo",
  (req, res, next) => {
    res.locals.id = getNextIdNumber();
    res.locals.name = req.body.name.trim().toUpperCase();
    res.locals.fooData = [1, 2, 3];
    next();
  },
  (req, res) => {
    res.render("bar", {
      id: res.locals.id,
      name: res.locals.name,
    });
  },
);
```
## `express-validator` ##
A module that provides many functions and methods to sanitize and validate user input. Many of these methods can be chained and used as middleware
The functions we are interested in for now:
```javascript
const { body, validationResult } = require("express-validator");
```

- `body` - A function that takes an argument and parses a req.body for the matching value of that argument
  - `trim` - Can trim whitespace from a string (normal JS function)
  - `isLength` - Checks if a string's length falls in a certain range. Can be passed an object argument speciying the min, max, or both
  - `isInt` - Checks if a string contains a number value (as a string). Optional range can be specified as an object argument with min, max, or both
  - `toInt` - Converts string to a number. Takes no arguments
  - `bail` - Exits validation chain if the validation method before it fails. Takes no arguments
  - `isAlpha` - Checks if string contains only alphabetic characters. Takes no arguments
  - `matches` - Checks if a string matches a regexular expression, which can be passed as an argument
  - `withMessage` - Add an error messages for the the preceding validation method if it fails

This is called validation API chaining and can be passed as a middleware function to any express routing method e.g `app.METHOD`
- These chains are typically passed into the routing method as an array (any middleware can be passed in an array or comma seperated)

```javascript
app.post("/contacts/new",
  [
    body("firstName")
      .trim()
      .isLength({ min: 1 })
      .withMessage("First name is required.")
      .bail()
      .isLength({ max: 25 })
      .withMessage("First name is too long. Maximum length is 25 characters.")
      .isAlpha()
      .withMessage("First name contains invalid characters. The name must be alphabetic."),
  ]
```

- `validationResult` - Takes a `req` as an argument, and returns an array of objets with information about any `errors` during validaiton
- `errors` - The standard variable name for the object returned by `validationResult`
  - `array` - Returns an array of all errors (as objects). Can specify an argument to narrow down returned errors e.g `{only: ['email']}
  - `isEmpty` - method returns a boolean based on if there are error objects generated from the `validationResult` invocation

Example of what an object returned by `errors.array` looks like
```
[
  {
    value: '', // value the user submitted
    msg: 'Email is required', // error message
    param: 'email', // the req.body value we are testing
    location: 'body'
  },
  {
    value: 'not an email',
    msg: 'Email must be valid',
    param: 'email',
    location: 'body'
  },
]
```

An example of using `validationResult` and the methods of the object it returns
```javascript
  (req, res, next) => {
    let errors = validationResult(req);
    if (!errors.isEmpty()) {
      res.render("new-contact", {
        errorMessages: errors.array().map(error => error.msg),
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        phoneNumber: req.body.phoneNumber,
      });
    } else {
      next();
    }
```
## Sessions
A period of interraction between a user and a website or a web application
- Duration of the the sessin is determined by how long the server stores the session data
  - Note that this is a slight distinciton from the cookie expiration time

## Session Persistance
Allow data to persist when our applicaton restarts, and allows each user to have their own saved data for the browser they are using
- This is opposed to all data being lossed when the application restarts
- Also means that different users no longer will see the same data on the page, as each session will be identified individually
  - Currently in our apps, there is no way to differentiate between HTTP request sources, and all data is stored in the same object
### `express-session`
A module that can be used to manage sessions. Mainly, it helps us handle cookies
- Module returns a `session` middleware function to manage session data
- When middleware is passed to `app.use`, it creates a `session` object on `req` objects that are used pass data to our specified datastore
   - `req.session` is how you manipulate the data store that you have specified in the `session` object argument 
- Has a built in `MemoryStore` that can be used for development purposes, but doesn't persist (each browser would see something different, but app restarts would delete data)
- Allows for use of external data stores that persist, list can be found in [documentation](https://www.npmjs.com/package/express-session)

**How it works**
1. Generates a unique **session ID** whenever a client browser makes an **initial** HTTP request to the application
2. Our application will store any data that needs to be persisted in a _specified_ DB under the corresponding session ID
3. Sends the generated Seesion ID back to the client browser in a cookie
4. Browser sends cookie back to browser as a part of each subsequent request
5. Application uses that cookie to fetch the stored data for that session

**How to use**
- `express-session` returns a `session` **midldleware function**
- `session` function takes an object argument with the following properties
  - The `cookie` property specifies a cookie object with the following required properties
    - `httpOnly` - Security related setting. Can be true/false. When true, does not allow borwser or client-side JS to access the cookie. **Should be true usually**
    - `maxAge` - How long until the cookie expires, in milliseconds
    - `path - specifies document location for cookie. Cookie will **only be sent if request path starts/matches with this path property**
      - e.g for `path: '/foo'`, the request path `/foo/bar` or `/foo` would match, but `/bar/foo` or `/bar` would not
    - `secure` - true means cookies will only be sent if the connection is HTTPS, false means it will send over HTTP or HTTPS
  - `name` - Name of sessions created by the application
  - `resave` - Whether the app should periodically resave the session data to the data store. Can usually be **false**
  - `saveUninitialized` - Whether save unitialized sessions' data in the store. Should be **true** if we are trying to persist data
  - `secret` - Used to sign and encrypt session cookie. Can just be a string
  - `store` - Should reference our data store, e.g `new LokiStore({})`

Remember that **Session persistence** does not play the same role as a **central database**
- Session peristance is temporary (until either server gets rid of data, or cookie expires)
- cenrtral database stores data for much longer periods of time, and is considered _permanent storage_
  - information isn't dependent on a session ID
 
Sessoin ID can be lost many ways
- session cookie expired
- user switches to a different browser
- cookie is erased from browser
- Server loses session ID

### `connect-loki`
A module that includes a NoSQL database used to persist data
- Stores it in a local file called `session-store.db`
  - ADD THIS TO `.gitignore`, pushing it to github is **compromising** the data

**How to use**
- `connect-loki` module returns a constructor that can be passed our session generated from `expression-session`\
- Use constructor to create a new persisting data store. Pass constructor an empty object to initialize with default parameters
  - has optional `path` that can be passed with object to specify path to database file, default is `session-store.db` in current dir


```
npm install express-session connect-loki --save
```
```javascript
const session = require('express-session'); // returns middleware function use to manage session data
const store = require('connect-loki'); // returns middleware function to initalize a data store using express session data
const LokiStore = store(session); // initalize data store for express session data (NoSQL DB)

app.use(session({
  cookie: {
    httpOnly: true,
    maxAge: 31 * 24 * 60 * 60 * 1000, // 31 days in milliseconds
    path: "/",
    secure: false,
  },
  name: "launch-school-contacts-manager-session-id",
  resave: false,
  saveUninitialized: true,
  secret: "this is not very secure",
  store: new LokiStore({}),
}));
```
## `express-flash`
A middleware that allows you to display flash messages after a request has been made
- Flash messages are messages that are stored in session data and display to the user on the next request
- Must be used with `express-session`

### How it works ###
1. When middleware returned from `express-flash` is passed to `app.use`, it creates a `flash` object on `req.session` to store messages
  - Also adds a `flash` method to `req` object that can be called to return message object on `req.session.flash`
    - Can be passed two arguments to add a flash message to the message object: a name and a message
    - This can be used in conjunction with `validationResult` from `express-validator` to create flash messages
    - **If called with no arguments or one argument, it retrieves the message object/key respectively, and removes it from req.session.flash`
      - This is why these messages display only once, despite being stored in session data
2. Can also a middleware to store reference to `req.session.flash` in an object on `res.locals` to allow all views to access any message that we want to display after a redirect
  - This is because we might want a view to be able to render messages after a redirect without having to pass the messages to the renderer
  - This technique requires deleting `req.session.flash` afterwards as we don't want flash messages to persist on refresh
    - This is because with this technique, since our messaages are stored on res.locals, we don't call `req.flash` to retrieve them and remove them from 

**Note about displaying flash messages in express**
- For messages that display after a redirect (submission confirmation), these should be stored in persistant memory so that they are accessible
- For messages that display on the same page, this is not required as we can simply re-rendor the page and pass the messages to the view
`req.session.flash`
```javascript
const flash = require('express-flash');
app.use(flash());
```
```javascript
// example of adding messages to req.session.flash, then retrieving and removing them to pass to the renderer to use in our views
  (req, res, next) => {
    let errors = validationResult(req);
    if (!errors.isEmpty()) {
      errors.array().forEach(error => req.flash("error", error.msg));

      res.render('new_contact', {
        flash: req.flash(),
        firstName: req.body.prevFirstName,
        lastName: req.body.prevLastName,
        phoneNumber: req.body.prevPhoneNumber,
      });
    } else {
      next();
    }
```


```javascript
// example of middleware to avoid having to retrieve messages with `req.flash`
app.use((req, res, next) => {
  res.locals.flash = req.session.flash;
  delete req.session.flash;
  next();
});
```
