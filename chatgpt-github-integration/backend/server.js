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
  console.log(`Server running on http://localhost:${PORT}`);
});
