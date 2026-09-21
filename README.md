# Voltfuscator

Voltfuscator is a hosted Lua 5.1 and Luau obfuscation service maintained by **Voltils**. It is designed to increase the time and effort required to inspect, copy, or reconstruct a Lua program while keeping the protected program usable in its intended runtime.

> Current production version: **Voltfuscator v7.5**  
> Current public preset: **Normal**

[Website](https://voltils.cc) · [Web obfuscator](https://voltils.cc/obfuscate/) · [Discord](https://discord.gg/78yYmtaeg4) · [API health](https://api.voltils.nxtdev.xyz/v1/health)

## Current service

Voltfuscator currently provides one maintained public preset instead of several overlapping strength levels. The **Normal** preset is the same production preset used by the website, authenticated API, and Discord bot.

At a high level, the current release provides:

- Lua 5.1 and supported Luau input handling
- Whole-program protection intended for Roblox and other compatible Lua environments
- Virtualized and transformed program logic
- Protected strings, constants, numbers, identifiers, and control flow
- Randomized output between builds
- Minified, self-contained output with no extra runtime file to distribute
- Anti-tamper protection enabled by default on the public API
- Optional Anti-HTTP Spy protection through the Discord bot
- Syntax validation and clear errors for invalid or unsupported input

This repository intentionally does not document internal algorithms, keys, generated instruction formats, or implementation details.

## Ways to use Voltfuscator

### Website

Use the hosted interface at [voltils.cc/obfuscate](https://voltils.cc/obfuscate/). The website uses the current production backend and Normal preset.

### Discord bot

Join the [Voltils Discord](https://discord.gg/78yYmtaeg4), then send the bot a direct message containing a `.lua` or `.txt` attachment. The bot opens an obfuscation panel where you can review the file and available protection options before processing it.

Current bot behavior:

- Accepts `.lua` and `.txt` attachments
- Maximum input size: **350 KiB**
- Uses the production **Normal** preset
- Anti-tamper is enabled for new sessions
- Anti-HTTP Spy can be enabled from the panel when the target runtime supports the required checks
- Requires acceptance of the Terms of Service and Privacy Policy
- Requires `dsc.gg/obfuscating` in the user's visible Discord status
- Standard limit: **3 obfuscations per 12 hours** with a **10-minute cooldown**

Operational limits may change as capacity and abuse controls are adjusted.

### API

The authenticated production endpoint is:

```text
POST https://api.voltils.nxtdev.xyz/v1/obfuscate
Authorization: Bearer <API_KEY>
Content-Type: application/json
```

Request body:

```json
{
  "code": "print('Hello from Voltfuscator')",
  "preset": "normal"
}
```

Successful response:

```json
{
  "success": true,
  "obfuscated": "<protected Lua output>"
}
```

API notes:

- An issued Voltfuscator API key is required.
- `code` must be valid UTF-8 Lua/Luau source text.
- `preset` is optional and currently accepts only `normal`.
- Maximum source size: **500 KiB**.
- API requests are rate-limited.
- Anti-tamper is enabled by the production API; individual internal passes are not exposed as request options.

The unauthenticated health endpoint is available at:

```text
GET https://api.voltils.nxtdev.xyz/v1/health
```

## Compatibility and expectations

Voltfuscator targets Lua 5.1 and Luau. Platform-specific globals and APIs used by an input script must still exist in the environment where the output runs. Because obfuscation increases file size and startup work, test protected output in the real target environment before distributing it.

Obfuscation is not encryption, access control, or a substitute for server-side security. A determined analyst who controls the runtime may still observe program behavior and values used during execution. Secrets, private keys, privileged decisions, and authoritative validation should remain on a trusted server.

Voltfuscator's goal is to make unauthorized analysis and source recovery substantially more expensive—not to promise that client-side code can never be analyzed.

## Example output

[example.lua](./example.lua) is an included Voltfuscator v7.5 output sample. It is intentionally large and machine-generated. The sample demonstrates the shape of production output; it is not a copy of the obfuscator implementation.

## Repository scope

This is a public information and output-sample repository. It is **not** the complete production obfuscator source tree.

```text
README.md                       Public documentation
example.lua                     Voltfuscator v7.5 output sample
source/Voltfuscator/vm.lua      Source-availability notice
```

## Privacy and policies

Submitted source is processed to produce an obfuscated result and is not intended to be retained by Voltils as a reusable source-code archive. When using Discord or another third-party service, that platform's own data handling may also apply. Review the current policies before submitting code:

- [Terms of Service](https://voltils.cc/tos/)
- [Privacy Policy](https://voltils.cc/privacy/)
- [Use Policy](https://voltils.cc/use-policy/)

Only submit code that you own or are authorized to process.

## Community

For service access, API-key availability, support, and current announcements, join the [Voltils Discord server](https://discord.gg/78yYmtaeg4).
