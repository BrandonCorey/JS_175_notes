## Routes ##
- A route can be thought of as a particular **combination** of **HTTP** method and **URL path**, and the **application logic that is executed when that combination is matched** in order to generate an HTTP response
  - The application logic that is executed is commonly referred to as a request handler

- Route --> HTTP method + Url path + request handler
  - request handler is the aplication logic that takes the request as input and generates an HTTP response
- Routes let you use the URL path as an abstraction, rather than as a reference to a specific location within the server file system
- Within a networked application, routing is often handled by a routing engine which abstracts away the complexity of matching routes and executing request handlers

```javascript
      if (method === 'GET' && pathname === '/') { // --> part of first route
        getIndex(res); // request handler --> part of first route
      } else if (method === 'GET' && pathname === '/loan-offer') { // --> part of second route
        getLoanOffer(res, path); // request handler --> part of second route
      } else if (method === 'POST' && pathname === '/loan-offer') { // --> part of third route
        postLoanOffer(req, res); // request handler --> part of third route
      } else {
        res.statusCode = 404;
        res.end();
```
