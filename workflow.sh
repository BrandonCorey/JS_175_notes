#!/usr/bin/bash

# Adds app #
if [ -z "$1" ]
then
  filename="app.js"
else
  filename="$1"
fi

touch "$filename"

# Initialize npm package
npm init -y

# Install dependencies and dev-dependencies
npm install express --save
npm install pug --save
npm install nodemon --save-dev
npm install eslint eslint-cli babel-eslint --save-dev

# adds a "start" command to package.json "script" object with value of "nodemon app.js"
APP_MAIN=$(grep -Eo '"main":.*?[^\\]",?' package.json | sed 's/"main": "\(.*\)",/\1/')
npm set-script start "npx nodemon $APP_MAIN"
# code here

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
echo -e "\n\033[96mYour express app is ready! To start, run: npm start\033[0m"
