// nextjs/pages/api/vault_secrets.js
import vault from 'node-vault';

const client = vault({
  apiVersion: 'v1',
  endpoint: 'http://localhost:8200',
  token: process.env.VAULT_TOKEN
});

export default async function handler(req, res) {
  try {
    const result = await client.read('secret/data/mysecret');
    res.status(200).json({ secret: result.data.data.key });
  } catch (error) {
    console.error('Error fetching secret:', error);
    res.status(500).json({ error: 'Failed to fetch secret' });
  }
}