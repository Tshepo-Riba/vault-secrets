// dotnet/Program.cs
using System;
using System.Threading.Tasks;
using VaultSharp;
using VaultSharp.V1.AuthMethods.Token;
using VaultSharp.V1.Commons;

class Program
{
    static async Task Main(string[] args)
    {
        var vaultAddress = "http://localhost:8200";
        var vaultToken = "myroot";

        var vaultClientSettings = new VaultClientSettings(vaultAddress, new TokenAuthMethodInfo(vaultToken));
        IVaultClient vaultClient = new VaultClient(vaultClientSettings);

        // Write a secret
        await vaultClient.V1.Secrets.KeyValue.V2.WriteSecretAsync("mysecret", new Dictionary<string, object>
        {
            { "key", "value" }
        });

        // Read a secret
        var secret = await vaultClient.V1.Secrets.KeyValue.V2.ReadSecretAsync("mysecret");
        Console.WriteLine($"Secret: {secret.Data.Data["key"]}");
    }
}