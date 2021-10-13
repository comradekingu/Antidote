#!/bin/sh

echo git submodule update --init
git submodule update --init

echo bundle exec pod install --verbose
bundle exec pod install --verbose
