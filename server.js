const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 8080;

// Serve static files (frontend)
app.use(express.static(path.join(__dirname, 'public')));

// Simple backend API
app.get('/api/message', (req, res) => {
  res.json({
    message: 'Hello from Azure App Service ',
    backendStatus: 'Backend is connected successfully!'
  });
});

// Serve frontend
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => console.log(`✅ Backend running on port ${PORT}`));
