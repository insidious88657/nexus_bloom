const express = require('express');
const app = express();
app.use(express.json({ limit: '50mb' })); // Larger for model deltas

let globalModel = {}; // In-memory aggregate (abstract later)
let clientCount = 0;

app.post('/upload-delta', (req, res) => {
  const { clientId, delta } = req.body;
  clientCount++;
  console.log(`Received delta from client ${clientId}. Total clients: ${clientCount}`);

  // Simple FedAvg simulation: average incoming deltas
  Object.entries(delta).forEach(([key, value]) => {
    if (!globalModel[key]) globalModel[key] = 0;
    globalModel[key] = (globalModel[key] * (clientCount - 1) + value) / clientCount;
  });

  res.json({ status: 'delta_received', aggregatedParams: Object.keys(globalModel).length });
});

app.get('/latest-model', (req, res) => {
  res.json({ model: globalModel, version: clientCount });
});

const port = process.env.SERVER_PORT || process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`NexusBloom Federation Simulator running on http://localhost:${port}`);
});
