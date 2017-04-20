#!/usr/bin/env bash

echo "Removing gems directory..."
rm -rf gems
echo "Removing .bundle directory..."
rm -rf .bundle
echo "Removing Gemfile.lock file..."
rm -f Gemfile.lock
echo

bundle install --standalone --path=./gems
