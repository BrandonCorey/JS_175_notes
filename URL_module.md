# Node `url` module #
This module has a `URL` class that we can use to constuct new `URL` objects
- Constructor takes a `path` argument and a base URL argument
## Use properties of `URL` instances ##
- `href` - hyperlink reference
- `origin` - base URL
- `protocol` - scheme
- `host` - host
- `pathname` - path
- `search` - query string
- `searchParams` - an instance of URLSearchParams class. Contains query parameters and values in an object as well as an interface to interract with them

### `URLSearchparams` ###
Instance methods
- `get` - Takes argument of URL parameter and returns corresponding value e.g
- `delete` - Takes arguent of URL parameter and deletes it from URL object
- `set` - Takes argument of URL parameter and corresponding value and creates query string
- `append` Takes argument of URL parameter and corresponding value and appends to existing query string

```javascript
const HTTP = require('http');
const URL = require('url').URL; // URL class
const PORT = 3000;

const dieRoll = (sides) => {
  return Math.floor(Math.random() * sides) + 1;
}

const getParams = (path) => {
  const url = new URL(path, `http://localhost:${PORT}`);
  return  url.searchParams; // { rolls: x => sides: y }
}

const rollDice = (params) => {
  const [ rolls, sides ] = [params.get('rolls'), params.get('sides')];
  let result = '';

  for (let count = 0; count < rolls; count++) {
    result += dieRoll(sides) + '\n';
  }

  return result;
}

const SERVER = HTTP.createServer((req, res) => {
  const method = req.method;
  const path = req.url;

  if (path === '/favicon.ico') {
    res.statusCode = 404;
    res.end();
  } else {
    const params = getParams(path);
    const nums = rollDice(params);

    res.writeHead(200, {
      'Content-Type': 'text/plain',
    });

    res.write(`${nums}\n`);
    res.write(`${method} ${path}\n`);
    res.end();
  }
});

SERVER.listen(PORT, () => {
  console.log(`Listening on port ${PORT}...`);
});
```
