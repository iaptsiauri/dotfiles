#!/usr/bin/env bash

# npm settings. No global packages: install build tools per project as
# devDependencies and run them with npx.

# `npm install <pkg>` pins the exact version that was current when you ran it
npm config set save-exact true
