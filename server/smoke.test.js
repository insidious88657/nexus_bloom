// Minimal smoke test for federation simulator endpoints using Node 18+ fetch
const assert = require('node:assert');

(async () => {
  const port = process.env.SERVER_PORT || 3000;
  const base = `http://localhost:${port}`;

  // Upload a couple of deltas
  let r = await fetch(`${base}/upload-delta`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ clientId: 'test1', delta: { a: 1.0, b: 3.0 } }),
  });
  assert.equal(r.status, 200);
  let j = await r.json();
  assert.equal(j.status, 'delta_received');

  r = await fetch(`${base}/upload-delta`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ clientId: 'test2', delta: { a: 3.0, b: 1.0 } }),
  });
  assert.equal(r.status, 200);

  // Get latest model
  r = await fetch(`${base}/latest-model`);
  assert.equal(r.status, 200);
  j = await r.json();
  assert.ok(j.model);
  // After averaging deltas from [1,3] and [3,1], expect 2 each with version 2
  assert.equal(j.model.a, 2.0);
  assert.equal(j.model.b, 2.0);
  assert.equal(j.version, 2);

  console.log('server smoke test: OK');
})().catch((e) => {
  console.error(e);
  process.exit(1);
});