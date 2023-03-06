## A networked application ###
- Broadly - Any application which uses a network connection in some way, primarily to transfer data between one piont and another
- More typical definition - an application that provides some sort of service to an individual end user so that each user will recieve content tailored to them

## Static vs Dynamic Content ##
### Static content ###
- Content that does not change and will be rendered by the browser the same way every time
  - Files are pre-created and stored on the server, waiting to be served
  - The content itself (the files) must be updated for the content to change
  - Can be any type of file, CSS, HTML, JS, images, videos etc
- This does not mean static conent cannot be interactive or animated, however this behavior will reside in the client (using CSS or JS or both)
- All we require is an HTTP server, and a file system for the pre-created content

![image](https://user-images.githubusercontent.com/93304067/222995416-f62b8da2-b343-4a61-9c4f-f316b71ac283.png)

### Dynamic content ###
- Content that is generated on the fly in response to individual HTTP requests
- Instead of serving a locally hosted file, the server does some processing to produce a response for the client
  - ex) combines data stored in a database with an HTML template to generate the complete HTML
- Typically, an HTTP server will recieve the request and send the response, whereas an application server will process the response
- Networked applications do not necessarily need to utilize a database

**The high level model for creating a dynamic response**
1. A request is received
2. Some processing occurs
3. A response is sent based on the result of that processing

![image](https://user-images.githubusercontent.com/93304067/222995561-7ae929b5-d3b9-4979-bee1-7f6a26322c14.png)

OR

![image](https://user-images.githubusercontent.com/93304067/222995986-84f68b8f-3210-49e4-97ae-c551dfd06542.png)

### Client responsibility ###
In both of the above examples, the client parses the response and produces what it needs to. It does not care about what processing the server does
- NOTE, in mordern development, there are many client side rendering techniques that take place with **Single Page Applications** (SPA)
  - This means that the necessary _resources/assets_ are served to the client, who then **processes** them on the front end
  - This means that for client-side generated content, far less HTTP requests and page refreshes need to be made since the browser does the processing itself
  - We will **NOT** focus on SPA's in this course
