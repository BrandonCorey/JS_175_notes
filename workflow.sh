#!/usr/bin/bash

# Initialize npm package
npm init -y

# Install dependencies and dev-dependencies
npm install express --save
npm install pug --save
npm install nodemon --save-dev
npm install eslint eslint-cli babel-eslint --save-dev

# Add script for `npm start` that executes `nodemon` for program
echo "\"scripts\": {
    \"start\": \"nodemon ${main}\"
  }," >> package.json

# Create views directory for pug files
mkdir views

# Create layout pug file for any boilerplate to be included in all files
touch views/layout.pug

# Create includes directory for any pug files you want to import to other pug files
mkdir views/includes

# Create public directory for static assets
mkdir public

# Create stylesheets directory for external CSS
mkdir public/stylesheets

# Output instructions for running the app
echo "Your app is ready! To start, run: npm start"
