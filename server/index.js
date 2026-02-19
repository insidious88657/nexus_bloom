// WARP_PROMPT: Implement a simple Express server for federated learning simulation. Endpoints: POST /upload-delta (receive model delta), GET /latest-model (send aggregated model). Use in-memory storage for dev. Make stateless.

const express = require('express');
const app = express();
app.use(express.json({ limit: '10mb' })); // For model deltas

let aggregatedModel = {}; // In-memory sim (abstract to DB later)

app.post('/upload-delta', (req, res) => {
  const delta = req.body.delta;
  // Simulate aggregation (e.g., average deltas)
  Object.keys(delta).forEach(key => {
    aggregatedModel[key] = (aggregatedModel[key] || 0) + delta[key];
  });
  res.status(200).send({ message: 'Delta received' });
});

app.get('/latest-model', (req, res) => {
  res.status(200).json(aggregatedModel);
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Server on port ${port}`));
