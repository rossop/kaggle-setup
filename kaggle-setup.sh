#!/bin/bash

# Check if a project name was provided as an input argument
if [ $# -eq 0 ]; then
    echo "No project name provided. Usage: ./setup-kaggle.sh <project_name>"
    exit 1
fi

# Use the first argument as the project root directory name
project_root=$1

# Create project directory structure

# Explicitly create each directory
mkdir -p $project_root/data/raw
mkdir -p $project_root/data/processed
mkdir -p $project_root/notebooks
mkdir -p $project_root/src/data
mkdir -p $project_root/src/features
mkdir -p $project_root/src/models
mkdir -p $project_root/src/visualisation
mkdir -p $project_root/output
mkdir -p $project_root/tests

echo "Project directories created for $project_root."


# Create a requirements.txt file with necessary Python packages
cat <<EOT >> $project_root/requirements.txt
pandas
numpy
scikit-learn
matplotlib
seaborn
jupyter
kaggle
EOT

echo "Requirements file created."

# Create .gitignore file
cat <<EOT >> $project_root/.gitignore
# Byte-compiled / optimised / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Jupyter Notebook checkpoints
.ipynb_checkpoints

# PyInstaller
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/
cover/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# PyCharm
.idea/
*.iml

# VSCode
.vscode/

# Environment variables
.env

# Virtualenv
venv/
ENV/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/

# Kaggle API credentials
kaggle.json

# Data
data/raw/*
data/processed/*

EOT

echo ".gitignore file created."

# Create README.md
cat <<EOT >> $project_root/README.md
# Kaggle Competition Project

This is a structured project repository for a Kaggle competition. It includes directories for datasets, notebooks for exploration, source code for models and features, and outputs for submissions and models.

## Structure

- \`data/\`: Raw and processed data.
- \`notebooks/\`: Jupyter notebooks for exploration and experiments.
- \`src/\`: Source code.
- \`output/\`: Output files like submission files.
- \`tests/\`: Test cases.

\`\`\`
kaggle_project/
├── data/
│   ├── raw/        # Original, immutable data dump
│   └── processed/  # Cleaned and processed data
├── notebooks/      # Jupyter notebooks for exploration and presentation
├── src/            # Source code for use in this project
│   ├── __init__.py
│   ├── data/       # Scripts to download or generate data
│   ├── features/   # Scripts to turn raw data into features for modelling
│   ├── models/     # Scripts to train models and then use trained models to make predictions
│   └── visualisation/ # Scripts to create exploratory and results-oriented visualisations
├── output/         # Final analysis output (e.g., models, submission files)
├── tests/          # For any tests to your code
└── requirements.txt
\`\`\`

## Setup

1. Create and activate a virtual environment.
2. Install requirements: \`pip install -r requirements.txt\`.
3. Download competition data using the Kaggle API.

## Usage

Explore datasets with notebooks, develop features and models in \`src/\`, and place outputs in \`output/\`.

EOT

echo "README.md file created."

# Create LICENSE
cat <<EOT >> $project_root/LICENSE
MIT License

Copyright (c) [year] [full name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOT

echo "LICENSE file created."

# Create and activate virtual environment
python3 -m venv $project_root/venv
source $project_root/venv/bin/activate

# Install requirements
pip install -r $project_root/requirements.txt

echo "Python dependencies installed."

# Content of CONTRIBUTING.md
read -r -d '' content << 'EOF'
# Branching Strategy for Kaggle Competition Project

This document outlines our project's branching strategy, designed to streamline development, feature integration, and hotfix application. Our strategy is built on three main types of branches: `feature`, `hotfix`, and `develop`.

## Branch Types

### `develop` Branch

- **Purpose**: Serves as the main development branch, containing the latest code that is in development.
- **Usage**: All feature and hotfix branches branch off from `develop` and are merged back into it once they are ready.

### `feature` Branches

- **Naming Convention**: `feature-<feature-name>`
- **Purpose**: Used for developing new features or enhancements.
- **Usage**:
  - Branch off from: `develop`
  - Merge back into: `develop`
  - Each new feature should have its own branch.
  - Merge requests (MRs) or pull requests (PRs) are used to merge feature branches back into `develop` after code review.

### `hotfix` Branches

- **Naming Convention**: `hotfix-<issue>`
- **Purpose**: Used to quickly fix issues in the live environment.
- **Usage**:
  - Branch off from: `develop`
  - Merge back into: `develop` and then into `main` or `master` if the fix needs to go live immediately.
  - Hotfix branches allow for quick fixes without disrupting the main development workflow.

## Workflow Summary

1. **Development**: Starts from the `develop` branch.
2. **Features**: Work on new features in `feature` branches, then merge back into `develop`.
3. **Hotfixes**: Address immediate issues in `hotfix` branches, then merge into both `develop` and `main`/`master`.
4. **Stable Releases**: Periodically, `develop` can be merged into `main`/`master` for stable release versions.

## Dos and Don'ts

### Dos

- **Do** keep your branch up to date with the base branch (usually `develop`).
- **Do** ensure your feature or hotfix is fully tested before creating a pull request.
- **Do** follow naming conventions for branches to maintain consistency and readability.
- **Do** use descriptive commit messages that explain the "why" behind changes.
- **Do** review pull requests thoroughly before merging.

### Don'ts

- **Don't** merge your own pull requests without at least one peer review.
- **Don't** commit directly to the `develop` or `main`/`master` branches. Always use feature or hotfix branches.
- **Don't** let your branches get too far ahead of `develop`—regularly merge changes from `develop` into your feature/hotfix branch.
- **Don't** leave branches open after they’ve been merged. Close them to keep the repository clean.

## Conclusion

Following this branching strategy will help keep our project organised, facilitate efficient collaboration among team members, and ensure that our codebase remains stable and easy to manage.
EOF

# Create CONTRIBUTING.md in the project root
echo "$content" > "$project_root/CONTRIBUTING.md"
echo "CONTRIBUTING.md has been created in $project_root."



# Navigate to the project root directory
cd $project_root


# Create a Dockerfile in the project root
cat <<EOT >> $project_root/Dockerfile
# Use the official Kaggle Python image
FROM kaggle/python

# Set the working directory in the container
WORKDIR /usr/src/app

# The Kaggle Python docker image comes with many data science and machine learning
# libraries pre-installed. If your project requires additional libraries not included 
# in the Kaggle image, uncomment the COPY and RUN lines below to install them.

# Copy the requirements file into the container
COPY requirements.txt ./

# Install any dependencies not already included in the Kaggle image
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files into the container
COPY . .

EOT

echo "Dockerfile created."



# # Build the Docker image with a tag
# cd $project_root
# docker build -t kaggle_project_image .

# echo "Docker image built with tag 'kaggle_project_image'."

# # Run the Docker container, mounting the project_root as a volume
# docker run -it --rm -p 8888:8888 -v "$PWD":/home/kaggle_project kaggle_project_image

# echo "Docker container is running with project_root mounted as a volume."


# Deactivate the virtual environment (if you were using one)

# Update requirements.txt
pip freeze > requirements.txt
deactivate

git init
git add .
git commit -m "First commit"

# Rename the current branch to 'main'
git branch -m master main

echo "Git repository initialised and first commit made."

# Check if kaggle.json exists in the same directory as the setup-kaggle.sh script
if [ -f "$(dirname "$0")/kaggle.json" ]; then
    # If it exists, copy kaggle.json to the project_root directory
    cp "$(dirname "$0")/kaggle.json" $project_root/kaggle.json
    echo "kaggle.json copied to $project_root."
else
    # If kaggle.json does not exist, print a warning message
    echo "Warning: kaggle.json not found in the script's directory. Please ensure it is placed in the project_root manually if needed."
fi


# Instructions for Kaggle API setup and data download
echo "Please ensure your Kaggle API key is set up in ~/.kaggle/kaggle.json."
echo "To download competition data, use: kaggle competitions download -c [competition-name] -p $project_root/data/raw"
