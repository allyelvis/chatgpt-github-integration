#!/bin/bash

# Configuration
PROJECT_NAME="ai_business_library"
AUTHOR_NAME="Ally Elvis Nzeyimana"
GITHUB_USERNAME="allyelvis"
GITHUB_EMAIL="naelvis6569@gmail.com"

# Exit on error
set -e

# Colors for output
GREEN="\033[0;32m"
NC="\033[0m"

echo -e "${GREEN}Starting the setup of ${PROJECT_NAME}...${NC}"

# Step 1: Create project directory
if [ ! -d "$PROJECT_NAME" ]; then
  echo -e "${GREEN}Creating project directory...${NC}"
  mkdir "$PROJECT_NAME"
fi

cd "$PROJECT_NAME"

# Step 2: Setup directories for various industries and businesses
echo -e "${GREEN}Setting up industry-specific directories...${NC}"
mkdir -p libraries/{retail,healthcare,education,finance,logistics,ai_tools}
mkdir -p assets/{images,styles,templates,documents}
mkdir -p prebuilt_apps/{ecommerce,crm,erp,inventory,pos}

# Step 3: Create prebuilt app templates
echo -e "${GREEN}Creating prebuilt app templates...${NC}"
# Retail
cat > prebuilt_apps/pos/main.js <<EOL
// POS System Main File
console.log("POS System Initialized");
EOL

# E-commerce
cat > prebuilt_apps/ecommerce/main.js <<EOL
// E-commerce Main File
console.log("E-commerce System Initialized");
EOL

# CRM
cat > prebuilt_apps/crm/main.js <<EOL
// CRM System Main File
console.log("CRM System Initialized");
EOL

# Step 4: Install AI tools dependencies
echo -e "${GREEN}Setting up AI tools dependencies...${NC}"
cd libraries/ai_tools
npm init -y
npm install openai @octokit/rest axios cors

# Create a template for AI integration
cat > ai_integration.js <<EOL
const { Configuration, OpenAIApi } = require("openai");

const configuration = new Configuration({
  apiKey: "your-api-key",
});

const openai = new OpenAIApi(configuration);

async function chatWithAI(prompt) {
  const response = await openai.createChatCompletion({
    model: "gpt-3.5-turbo",
    messages: [{ role: "user", content: prompt }],
  });
  return response.data.choices[0].message.content;
}

module.exports = { chatWithAI };
EOL

cd ../../..

# Step 5: Add assets and templates
echo -e "${GREEN}Adding assets and templates...${NC}"

# Adding a sample style
cat > assets/styles/style.css <<EOL
/* Sample Style */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  background-color: #f4f4f9;
}
EOL

# Adding a sample document template
cat > assets/templates/template.html <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Template</title>
    <link rel="stylesheet" href="../styles/style.css">
</head>
<body>
    <h1>Welcome to the AI Business Library</h1>
</body>
</html>
EOL

# Step 6: Initialize Git repository
echo -e "${GREEN}Initializing Git repository...${NC}"
git init
git config user.name "$GITHUB_USERNAME"
git config user.email "$GITHUB_EMAIL"

# Create .gitignore
cat > .gitignore <<EOL
node_modules/
*.log
.env
EOL

# Step 7: Commit initial files
git add .
git commit -m "Initial commit for ${PROJECT_NAME}"

# Step 8: Publish to GitHub
echo -e "${GREEN}Publishing to GitHub...${NC}"
gh repo create "$GITHUB_USERNAME/$PROJECT_NAME" --public --source=. --remote=origin
git push -u origin main

echo -e "${GREEN}Setup complete!${NC}"
echo -e "Library created with assets, tools, and prebuilt apps."
