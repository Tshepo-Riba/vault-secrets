// nodejs/vault_secrets.js
const vault = require("node-vault")({
    apiVersion: "v1",
    endpoint: "http://localhost:8200",
    token: "myroot"
  });
  
  async function main() {
    try {
      // Write a secret
      await vault.write("secret/data/mysecret", { data: { key: "value" } });
  
      // Read a secret
      const result = await vault.read("secret/data/mysecret");
      console.log(`Secret: ${result.data.data.key}`);
    } catch (error) {
      console.error("Error:", error);
    }
  }
  
  main();