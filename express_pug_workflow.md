1. Initialize npm package
```
npm init
```
2. Install the appropriate dependencies and dev-dependencies
```
npm install express --save
npm install pug --save
npm install nodemon --save-dev
npm install eslint eslint-cli babel-eslint --save-dev
```
3. Add script for `npm start` that executes `nodemon` for program
```json
  "scripts": {
    "start": "nodemon <main_program_name>",
  },
```
4. Create `views` directory for pug files
```
mkdir views
```
5. Create `layout` pug file for any boilerplate to be included in all files
```
touch layout.pug
```
7. Create `includes` directory for any pug files you want to import to other pug files
```
mkdir views/includes
```
This is how you'll run your app
```
npm start
```
