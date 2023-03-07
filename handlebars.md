## Templating engines ##
Templating engines can be used in our code in place of JS template literals to compile HTML
- Some engines can be imported as modules (like handlebars)
- They allow us to compile an HTML template with placeholder values that can be added later
- This is better than template literals, which need to have their placeholder variables in scope when the interpreter reaches them

### How `handlebars` works ###
Gives us a `compile` method that takes HTML template literal as arg and returns a function that can generate the HTML
- The template literal containing the HTML must have use special syntax for placeholders `{{ variableHere }}`
- **returned function takes object argument** and uses its properties to plug in values for HTML
- The **properties** of the object argument **must be the same as the values in the HTML** used to compile the function

```javascript
// SOURCE template literal HTML with special spaceholders {{  }}
// e.g <a href='/?amount={{amount}}&duration={{durationDecrement}}'>- 1 year</a>
const LOAN_OFFER_TEMPLATE = HANDLEBARS.compile(SOURCE); 

const render = (template, data) => {
  let html = template(data) // the template function argument will be LOAN_OFFER_TEMPLATE
  return html;
}

const createLoan = (params) => {
  const APR = 5;
  let data = {};

  data.amount = Number(params.get('amount'));
  data.amountIncrement = data.amount + 100;
  data.amountDecrement = data.amount - 100;
  data.duration = Number(params.get('duration'));
  data.durationIncrement = data.duration + 1;
  data.durationDecrement = data.duration - 1;
  data.apr = APR;
  data.payment = calcPayment(data.amount, data.apr, data.duration).toFixed(2);

  return data;
}

const SERVER = HTTP.createServer((req, res) => {
  const path = req.url;
  let data = createLoan(getParams(path));
  let content = render(LOAN_OFFER_TEMPLATE, data)
  res.write(`${content}\n`); // HTTP/1.1 bodies end with new line
});
```
