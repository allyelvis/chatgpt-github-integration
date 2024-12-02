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
