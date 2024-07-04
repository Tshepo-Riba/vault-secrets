// react/src/VaultSecrets.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';

const VaultSecrets = () => {
  const [secret, setSecret] = useState(null);

  useEffect(() => {
    const fetchSecret = async () => {
      try {
        const response = await axios.get('/api/vault-secret');
        setSecret(response.data.secret);
      } catch (error) {
        console.error('Error fetching secret:', error);
      }
    };

    fetchSecret();
  }, []);

  return (
    <div>
      <h2>Vault Secret</h2>
      {secret ? <p>Secret: {secret}</p> : <p>Loading secret...</p>}
    </div>
  );
};

export default VaultSecrets;