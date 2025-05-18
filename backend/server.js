require('dotenv').config();
const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const FLOOZ_API_KEY = process.env.FLOOZ_API_KEY;
const TMONEY_API_KEY = process.env.TMONEY_API_KEY;

if (!FLOOZ_API_KEY || !TMONEY_API_KEY) {
  console.error('API keys for Flooz and Tmoney must be set in environment variables.');
  process.exit(1);
}

app.post('/recharge/flooz', async (req, res) => {
  const { phone, amount } = req.body;
  try {
    // Example request to Flooz API
    const response = await axios.post('https://api.flooz.com/recharge', {
      phone,
      amount,
    }, {
      headers: {
        'Authorization': `Bearer ${FLOOZ_API_KEY}`,
        'Content-Type': 'application/json',
      },
    });
    // Return token or response to app
    res.json({ token: response.data.token || 'dummy-token', data: response.data });
  } catch (error) {
    console.error('Flooz recharge error:', error.message);
    res.status(500).json({ error: 'Flooz recharge failed' });
  }
});

app.post('/recharge/tmoney', async (req, res) => {
  const { phone, amount } = req.body;
  try {
    // Example request to Tmoney API
    const response = await axios.post('https://api.tmoney.com/recharge', {
      phone,
      amount,
    }, {
      headers: {
        'Authorization': `Bearer ${TMONEY_API_KEY}`,
        'Content-Type': 'application/json',
      },
    });
    // Return token or response to app
    res.json({ token: response.data.token || 'dummy-token', data: response.data });
  } catch (error) {
    console.error('Tmoney recharge error:', error.message);
    res.status(500).json({ error: 'Tmoney recharge failed' });
  }
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Backend server running on port ${PORT}`);
});
