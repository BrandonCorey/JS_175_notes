# PUG
## Syntax:
Pug is a template engine that uses indentation to define the structure of your HTML. It also uses special syntax for other HTML elements. For example:
- To create a div element with a class of "container", you would write:
```pug
div.container
```

- To create a `h1` element with the text "Hell World", you write:
```pug
h1 Hello World
```

- To create a link to stylesheet file, you write:
```pug
link(rel="stylesheet" href="styles/stylesheet.css")
```

Pug code vs what it renders as HTML
```pug
html
  head
    title My Page
    link(rel='stylesheet', href='/styles/style.css')
  body
    h1 Welcome to My Page
    p This is some text on my page.
```
```html
<!DOCTYPE html>
<html>
  <head>
    <title>My Page</title>
    <link rel="stylesheet" href="/styles/style.css">
  </head>
  <body>
    <h1>Welcome to My Page</h1>
    <p>This is some text on my page.</p>
  </body>
</html>
```
