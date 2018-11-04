#!/usr/bin/env bash

if test ! $(which rvm) > /dev/null;then
  error "needs rvm to install ruby!!!"
  exit 2
fi

# Update rvm to latests stable version
rvm get stable --auto-dotfiles

# Install latests ruby, and use it as default
rvm install ruby
rvm --default use ruby


# Installing gems

sudo gem update --system

sudo gem install bundler
sudo gem install nokogiri

sudo gem install rails