#!/usr/bin/env bash

# Usage: ./init.sh <new-project-name>
# This script renames the template directory and reinitializes Git history to start a fresh project.

# Exit on error
set -e

if [ -z "$1" ]
then
  echo "Usage: $0 <new-project-name>"
  exit 1
fi

NEW_NAME=$1

# Ensure we are currently in the mlflow_langchain_template directory
CURRENT_DIR=$(basename "$PWD")
if [ "$CURRENT_DIR" != "mlflow_langchain_template" ]
then
  echo "Please run this script from within the 'mlflow_langchain_template' directory."
  exit 1
fi

# Move up one directory to rename the folder
cd ..
mv mlflow_langchain_template "$NEW_NAME"
cd "$NEW_NAME"

# Remove existing Git history and start fresh
rm -rf .git
git init
git add .
git commit -m "Initial commit"

echo "Project successfully renamed to '$NEW_NAME' and reinitialized."
echo "Next steps:"
echo "1. Create a new repository on GitHub named '$NEW_NAME' (if not done already)."
echo "2. Run the following commands:"
echo "   git remote add origin https://github.com/<your-username>/$NEW_NAME.git"
echo "   git push -u origin main"
