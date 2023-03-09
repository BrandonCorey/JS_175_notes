## Routes

Routes in Express JS define the endpoints that your application or API will respond to. Each route is associated with a specific HTTP method (e.g., GET, POST, PUT, DELETE) and a URL pattern. 

- Example of a route that responds to a GET request to the root URL of our application:

```javascript
app.get('/', (req, res) => {
  res.send('Hello, world!');
});
```

## Route handlers
Route handlers are functions that are executed when a route is matched. They can perform any necessary logic, such as querying a database or rendering a view, and then send a response back to the client.
- Example of a route handler that queries a database and sends the result back to the client:
- The entire function is a route, the **callback** argument is the **handler**
```javascript
app.get('/users/:id', (req, res) => {
  const id = req.params.id;
  const user = getUserById(id);
  res.json(user);
});
```

## Middleware Functions
Express middleware functions are callback functions used by Express methods like app.use and app.get, among others. These functions can access and manipulate the request and response objects per the application requirements. Middleware functions have the following signature:
- Executed after a request is recieved and before reponse is sent
- Executed based on order of their definitions
- Can be chained together using `next` parameter
- Some middleware functions are provided by `express`
- Functions are executed using `app.use`
```javascript
app.use((req, res, next) => {      // Middleware #1
  // do something
  if (somethingIsTrue) {
    res.render("foo");
  } else {
    next();
  }
});

app.use((req, res, next) => {      // Middleware #2
  // do something else
  next();
});

app.get("/stuff", (req, res) => {  // Middleware #3
  res.render("qux");
});
```

## Routers
Routers in Express JS are used to group related routes and handlers together. They can be used to break up a large application into smaller, more manageable pieces.
- Example of a router that handles all routes related to user authentication:
```javascript
const authRouter = express.Router();

authRouter.post('/login', (req, res) => {
  // handle login logic
});

authRouter.post('/logout', (req, res) => {
  // handle logout logic
});

app.use('/auth', authRouter);
```
