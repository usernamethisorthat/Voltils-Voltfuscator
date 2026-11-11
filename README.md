# Voltfuscator 8.0

[![Voltfuscator demo](source/Voltfuscator/assets/voltfuscator-demo.gif)](https://voltils.cc/)

**Voltfuscator** is a Lua 5.1 and Luau obfuscator by **Voltils**. It helps make scripts harder to read and reverse engineer while keeping them working as intended.

You can use it through the website, Discord bot, or API. No installation is needed.

[Website](https://voltils.cc/) · [Dashboard](https://voltils.cc/dashboard/#obfuscate) · [Documentation](https://voltils.cc/docs/) · [Discord](https://discord.gg/78yYmtaeg4)

## Getting started

1. Open the [dashboard](https://voltils.cc/dashboard/#obfuscate) and sign in with Discord.
2. Paste your code or upload a `.lua`, `.luau`, or `.txt` file.
3. Choose a preset and the runtime your script uses.
4. Obfuscate your script, then copy or download the result.

Make sure to test the output in the environment where you plan to use it.

## Presets

| Preset | Description |
| --- | --- |
| **Normal** | Recommended for everyday use. Balances protection and performance. |
| **Ultra** | Extra protection for scripts where performance and output size are less of a concern. |

**Normal** is selected by default. It replaces the previous Max preset; the older Normal preset has been retired.

## Plans and limits

Every new account starts on **Basic**. Your limits are shared across the website, Discord bot, and API.

| Plan | Builds per 12 hours | Builds per day (UTC) | Max source size |
| --- | ---: | ---: | ---: |
| Basic | 3 | 6 | 350 KiB |
| Pro | 12 | 24 | 450 KiB |
| Elite | 120 | 240 | 450 KiB |

The 12-hour limit is rolling, while daily limits reset at **00:00 UTC**. Failed builds don't count toward your successful-build quota.

For current plan details, check the [dashboard](https://voltils.cc/dashboard/).

## Discord bot

You can also obfuscate scripts through our [Discord server](https://discord.gg/78yYmtaeg4).

Send the bot a `.lua` or `.txt` file in DMs, follow its prompts to select your options, and wait for your result. The bot uses the same account limits as the website and API.

## API

Want to integrate Voltfuscator into your own tools? Sign in to the [dashboard](https://voltils.cc/dashboard/#keys) and create an API key under **API Keys**.

**Endpoint**

```http
POST https://voltils.cc/v1/obfuscate
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json
```

**Example request**

```json
{
  "code": "print('Hello from Voltfuscator!')",
  "preset": "normal",
  "runtime": "lua51"
}
```

**Example response**

```json
{
  "success": true,
  "obfuscated": "<protected Lua output>"
}
```

The available presets are `normal` and `ultra`. Supported runtime values include `lua51`, `luau`, `roblox`, `studio`, and `executor`.

Keep your API key private. For additional options, error responses, and integration examples, visit the [documentation](https://voltils.cc/docs/).

## Examples

This repository includes sample files so you can see what Voltfuscator output looks like:

| File | Description |
| --- | --- |
| `example.source.lua` | Readable example script |
| `example.lua` | Example protected with Voltfuscator 8.0 |

The protected example targets a Roblox executor environment. To protect your own scripts, use the [website](https://voltils.cc/) or API and select the appropriate runtime.

## Supported languages

Voltfuscator supports **Lua 5.1** and **Luau**, including Roblox-related runtimes. Some scripts may rely on APIs or language features specific to their environment, so test your output before sharing it.

## Help and policies

Need help or want to report an issue? Join the [Voltils Discord](https://discord.gg/78yYmtaeg4).

Only submit scripts you own or have permission to use. See our [Terms of Service](https://voltils.cc/tos/), [Privacy Policy](https://voltils.cc/privacy/), and [Use Policy](https://voltils.cc/use-policy/).
