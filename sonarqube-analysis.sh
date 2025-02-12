#!/bin/bash

# Set your project-specific values
PROJECT_KEY="test-project"
PROJECT_NAME="test-project"
SONAR_URL="http://sonarqube.vishalk17.com:9000"  # Update with your SonarQube server URL
BRANCH_NAME="master"  

# Define tool paths
BUILD_WRAPPER_PATH="/usr/local/bin/build-wrapper-linux-x86-64"
SONAR_SCANNER_PATH="/opt/sonar-scanner-7.0.1.4817-linux-x64/bin/sonar-scanner"

# Step 1: Check if the current branch is $BRANCH_NAME
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$CURRENT_BRANCH" != "$BRANCH_NAME" ]; then
  echo "Error: You are on branch '$CURRENT_BRANCH'. This script only runs on the '$BRANCH_NAME' branch."
  exit 1
fi

# Step 2: Prompt for the SonarQube token
read -sp "Enter your SonarQube token: " SONAR_TOKEN
echo  # This is to print a newline after the input

# Check if the token is empty
if [ -z "$SONAR_TOKEN" ]; then
  echo "Error: SonarQube token is required. Exiting."
  exit 1
fi

# Export the token for Sonar Scanner
export SONAR_TOKEN

# Step 3: Compile the project with the Build Wrapper
$BUILD_WRAPPER_PATH --out-dir bw-output make clean all


# Step 4: Run Sonar Scanner
$SONAR_SCANNER_PATH \
  -Dsonar.projectKey=$PROJECT_KEY \
  -Dsonar.projectName=$PROJECT_NAME \
  -Dsonar.sources=. \
  -Dsonar.inclusions="**/*.c,**/*.h" \
  -Dsonar.language=c \
  -Dsonar.cfamily.build-wrapper-output=bw-output \
  -Dsonar.host.url=$SONAR_URL \
  -Dsonar.token=$SONAR_TOKEN \
  -Dsonar.branch.name=$BRANCH_NAME

# Clean build-wrapper dir.
rm -rf ./bw-output
