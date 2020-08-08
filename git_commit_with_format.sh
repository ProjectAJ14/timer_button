#!/bin/bash
clear
git status
echo "Enter commit message : "
read commitMessage
echo "Formatting code with [flutter format]...."
flutter format lib
git add .
git commit -m "$commitMessage"
echo "Done"