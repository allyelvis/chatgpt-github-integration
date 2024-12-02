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
