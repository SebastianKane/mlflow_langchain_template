#!/usr/bin/env bash

# This script interactively sets up the project name and venv name.
# It then renames the directory, reinitializes the Git repository,
# creates and activates a virtual environment, and installs dependencies.

# Exit on any error
set -e

# Prompt for the new project name
read -p "Enter new project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    echo "Project name cannot be empty."
    exit 1
fi

# Prompt for the venv name (default: <project-name>-venv)
read -p "Enter venv name [default: ${PROJECT_NAME}-venv]: " VENV_NAME
if [ -z "$VENV_NAME" ]; then
    VENV_NAME="${PROJECT_NAME}-venv"
fi

# Ensure we are currently in the mlflow_langchain_template directory
CURRENT_DIR=$(basename "$PWD")
if [ "$CURRENT_DIR" != "mlflow_langchain_template" ]; then
    echo "Please run this script from within the 'mlflow_langchain_template' directory."
    exit 1
fi

# Move up one directory to rename
cd ..
mv mlflow_langchain_template "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Reinitialize Git
rm -rf .git
git init
git add .
git commit -m "Initial commit"

# Create and activate the virtual environment, install dependencies
python3 -m venv "$VENV_NAME"
source "$VENV_NAME/bin/activate"
pip install --upgrade pip
pip install -r requirements.txt

# Remove Template README
> README.md

echo "--------------------------------------------------------"
echo "Project successfully renamed to '$PROJECT_NAME' and reinitialized."
echo "A virtual environment '$VENV_NAME' has been created and activated."
echo
echo "Next steps:"
echo "1. Update your .env file (cp .env_template .env and edit accordingly)."
echo "2. Create a new repository on GitHub named '$PROJECT_NAME' (if not done already)."
echo "3. Run the following commands to set your remote and push:"
echo "   git remote add origin https://github.com/<your-username>/$PROJECT_NAME.git"
echo "   git push -u origin main"
echo
echo "When you're done, you can run:"
echo "   source $VENV_NAME/bin/activate"
echo "to reactivate your virtual environment."
echo "--------------------------------------------------------"


echo "Project successfully renamed to '$NEW_NAME' and reinitialized."
echo "Next steps:"
echo "1. Create a new repository on GitHub named '$NEW_NAME' (if not done already)."
echo "2. Run the following commands:"
echo "   git remote add origin https://github.com/<your-username>/$NEW_NAME.git"
echo "   git push -u origin main"
