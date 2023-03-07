## Routes ##
- A route can be thought of as a particular **combination** of **HTTP** method and **URL path**, and the **application logic that is executed when that combination is matched** in order to generate an HTTP response
  - The application logic that is executed is commonly referred to as a request handler
- Routes let you use the URL path as an abstraction, rather than as a reference to a specific location within the server file system
- Within a networked application, routing is often handled by a routing engine which abstracts away the complexity of matching routes and executing request handlers

Entire if statement below is the route, inside the route are request handlers
```javascript
      if (method === 'GET' && pathname === '/') {
        getIndex(res); // request handler
      } else if (method === 'GET' && pathname === '/loan-offer') {
        getLoanOffer(res, path); // request handler
      } else if (method === 'POST' && pathname === '/loan-offer') {
        postLoanOffer(req, res); // request handler
      } else {
        res.statusCode = 404;
        res.end();
```
