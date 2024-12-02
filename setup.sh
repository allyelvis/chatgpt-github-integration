#!/bin/bash

# Configuration
PROJECT_NAME="chatgpt-github-integration"
AUTHOR_NAME="Ally Elvis Nzeyimana"
GITHUB_USERNAME="allyelvis"
GITHUB_EMAIL="naelvis6569@gmail.com"

# Exit on errors
set -e

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

echo -e "${GREEN}Starting project setup for ${PROJECT_NAME}...${NC}"

# Step 1: Create project directory
if [ ! -d "$PROJECT_NAME" ]; then
  echo -e "${GREEN}Creating project directory...${NC}"
  mkdir "$PROJECT_NAME"
fi

cd "$PROJECT_NAME"

# Step 2: Create frontend and backend directories
echo -e "${GREEN}Setting up frontend and backend directories...${NC}"
mkdir -p frontend backend

# Step 3: Initialize frontend
cd frontend
echo -e "${GREEN}Initializing frontend...${NC}"
npm init -y
npm install react react-dom vite

# Generate Vite configuration file
cat > vite.config.js <<EOL
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
});
EOL

# Generate React App files
mkdir -p src
cat > src/App.jsx <<EOL
import React, { useState } from 'react';

function App() {
  const [repoLink, setRepoLink] = useState('');
  const [username, setUsername] = useState('');
  const [token, setToken] = useState('');
  const [apiKey, setApiKey] = useState('');
  const [prompt, setPrompt] = useState('');
  const [output, setOutput] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    const response = await fetch('http://localhost:5000/api/github', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ repoLink, username, token, apiKey, prompt }),
    });
    const data = await response.json();
    setOutput(data.result);
  };

  return (
    <div>
      <h1>ChatGPT GitHub Integration</h1>
      <form onSubmit={handleSubmit}>
        <input placeholder="GitHub Repo Link" value={repoLink} onChange={(e) => setRepoLink(e.target.value)} />
        <input placeholder="GitHub Username" value={username} onChange={(e) => setUsername(e.target.value)} />
        <input placeholder="GitHub Token" value={token} onChange={(e) => setToken(e.target.value)} />
        <input placeholder="OpenAI API Key" value={apiKey} onChange={(e) => setApiKey(e.target.value)} />
        <textarea placeholder="Prompt" value={prompt} onChange={(e) => setPrompt(e.target.value)} />
        <button type="submit">Execute</button>
      </form>
      <div>
        <h2>Output:</h2>
        <pre>{output}</pre>
      </div>
    </div>
  );
}

export default App;
EOL

cat > src/main.jsx <<EOL
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import './index.css';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
EOL

cat > index.html <<EOL
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ChatGPT GitHub Integration</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOL

cd ..

# Step 4: Initialize backend
cd backend
echo -e "${GREEN}Initializing backend...${NC}"
npm init -y
npm install express @octokit/rest openai cors

# Generate Express server file
cat > server.js <<EOL
const express = require('express');
const cors = require('cors');
const { Octokit } = require('@octokit/rest');
const { Configuration, OpenAIApi } = require('openai');

const app = express();
app.use(cors());
app.use(express.json());

app.post('/api/github', async (req, res) => {
  const { repoLink, username, token, apiKey, prompt } = req.body;

  try {
    // Initialize GitHub client
    const octokit = new Octokit({ auth: token });

    // Initialize OpenAI client
    const openai = new OpenAIApi(new Configuration({ apiKey }));

    // Process the prompt with ChatGPT
    const chatResponse = await openai.createChatCompletion({
      model: 'gpt-3.5-turbo',
      messages: [{ role: 'user', content: prompt }],
    });

    const responseText = chatResponse.data.choices[0].message.content;

    res.json({ result: responseText });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

const PORT = 5000;
app.listen(PORT, () => {
  console.log(\`Server running on http://localhost:\${PORT}\`);
});
EOL

cd ..

# Step 5: Final instructions
echo -e "${GREEN}Setup complete!${NC}"
echo -e "To start the project:"
echo -e "1. Open two terminals."
echo -e "2. In the first terminal, navigate to the backend folder and run:"
echo -e "   ${GREEN}node server.js${NC}"
echo -e "3. In the second terminal, navigate to the frontend folder and run:"
echo -e "   ${GREEN}npm run dev${NC}"
echo -e "Access the app at ${GREEN}http://localhost:3000${NC}"
