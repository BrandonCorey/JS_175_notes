# PUG
## Syntax:
Pug is a template engine that uses indentation to define the structure of your HTML. It also uses special syntax for other HTML elements. For example:
- To create a div element with a **class** of "container", you would write:
```pug
div.container
```

- To create an **id** of my_element, you can write:
```pug
div#myelement
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

## Extending Layouts with Blocks:

Pug allows you to create layout templates that can be extended by other templates. To do this, you create a layout template that includes blocks where content can be inserted by the child templates.
- Default values can be assigned for each block in the layout by nesting an element inside of it (using indentation)
  - These will be used if a matching block is not found in any of the views
```pug
// layout.pug
html
  head
    title My Site
  body
    header
      block headerText
      h1 Website
    main
      block content
    footer
      p Copyright © My Site
```
```pug
// english.pug
extends layout

block headerText
  h1 I created this website for practice!

block content
  p Hello, welcome to my website!
```
```spanish.pug
extends layout

block headerText
  h1 Yo hice el sitio web para practicar

block content
  p Hola, bienvenido a mi sitio web
```
