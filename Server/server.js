const https = require('https');
const fs = require('fs');
const path = require('path');
const express = require('express');

const app = express();
const PORT = 8443;  // Use a non-privileged port

// SSL options
const options = {
    key: fs.readFileSync(path.join(__dirname, 'key.pem')),
    cert: fs.readFileSync(path.join(__dirname, 'cert.pem'))
};c

// Serve static files from the "html" directory
app.use(express.static('html'));

// Serve index.html at the root
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'index.html'));
});

// Start the HTTPS server
https.createServer(options, app).listen(PORT, '0.0.0.0', () => {
    console.log(`HTTPS server running on https://localhost:${PORT}`);
});
