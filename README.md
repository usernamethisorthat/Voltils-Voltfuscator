# Voltfuscator

Voltfuscator is a hosted Lua 5.1 and Luau obfuscation service maintained by **Voltils**. It increases the effort required to inspect or reconstruct scripts while preserving their intended behavior.

Updated **October 10, 2026** for the current **Voltfuscator 7.6 Nyx** release.

[Website](https://voltils.cc/) · [Obfuscator dashboard](https://voltils.cc/dashboard/#obfuscate) · [Documentation](https://voltils.cc/docs/) · [Discord](https://discord.gg/78yYmtaeg4)

## Presets

Both presets are available through the website, Discord bot, and API:

| Preset | API value | Purpose |
| --- | --- | --- |
| Normal | `normal` | A balanced option for everyday use. |
| Max | `max` | Stronger protection; processing can take longer. |

Normal is the default when an API request omits `preset`. There is no public Light preset.

## Accounts and shared quotas

Sign in with Discord. New accounts start on **Basic**. Every signed-in account can generate and use API keys; API access does not require a Pro upgrade or manual approval.

| Tier | Successful obfuscations |
| --- | --- |
| Basic | **3 per rolling 12 hours** |
| Pro | **16 per rolling 12 hours** |

Website, bot, and API builds share the same account allowance. Creating more keys does not increase it. Each slot returns 12 hours after its successful build completes; midnight does not reset the allowance. Failed builds do not consume successful-build quota. Pending jobs temporarily reserve a slot.

## Website

1. Open [the dashboard](https://voltils.cc/dashboard/#obfuscate) and sign in with Discord.
2. Paste your Lua or Luau source.
3. Select **Normal** or **Max**, then obfuscate.
4. Copy or download the output before leaving the workspace.

## Discord bot

Join the [Discord server](https://discord.gg/78yYmtaeg4), then DM the bot a `.lua` or `.txt` attachment. Its panel lets you choose Normal or Max and review protection options.

- Accept the Terms of Service and Privacy Policy when prompted.
- Set `dsc.gg/obfuscating` in your visible Discord status.
- The bot has a **10-minute cooldown** per user.
- Anti-tamper starts enabled for new sessions.
- Optional Anti-HTTP Spy is available through the bot panel for compatible runtimes.
- Successful jobs use your shared Basic or Pro quota.

## Getting an API key

1. Sign in at [voltils.cc/dashboard](https://voltils.cc/dashboard/#keys).
2. Open **API Keys**, enter a name, and select **Create key**.
3. Store the key in a server-side environment variable.

Each account can have **up to three active keys**. You can view an active key again after signing in, or revoke it from the dashboard. Keys expire after **30 days without API use**. Never put your key in public repositories, browser code, or scripts you distribute.

## API

Use the current public endpoint:

```text
POST https://voltils.cc/v1/obfuscate
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json
```

Example request using Max:

```json
{
  "code": "print('Hello from Voltfuscator!')",
  "preset": "max"
}
```

Successful response:

```json
{
  "success": true,
  "obfuscated": "<protected Lua output>"
}
```

`code` must be nonempty UTF-8 source. `preset` accepts `normal` or `max` and defaults to `normal`. Account usage metadata is returned in the `X-Voltfuscator-Usage` response header. `GET https://voltils.cc/v1/obfuscate` returns service and tier information; it does not compile a script.

The old `api.voltils.nxtdev.xyz` URL is not the endpoint documented for current clients.

### Limits and errors

- Source size: **350 KiB** of UTF-8 text across the hosted service.
- Compiler budget: **60 seconds** per build.
- One active job per account; the compiler also has one processing slot.
- An interrupted connection can leave a reservation pending for up to **90 seconds**. A success already confirmed still counts.
- `400`: invalid request or preset; `401`: invalid, expired, or revoked credentials; `413`: invalid source size; `429`: quota, attempt limit, or compiler busy; `5xx`: temporary service/compiler failure.

Follow retry guidance when rate-limited or busy. Limits may change; the live dashboard and documentation are the current reference.

## Included examples

The examples were regenerated with the current release. Both protected files run the same source and print:

```text
Hello from Voltfuscator!
```

```text
README.md                      Service and API documentation
example.source.lua             Readable example input
example.lua                    Max protected output
source/Voltfuscator/vm.lua      Source-availability notice
```

Run either protected sample directly in a supported Lua 5.1 or Luau host. Keep its generated formatting intact. These examples are output samples, not the compiler implementation.

## Compatibility and source availability

This package is a public information and output-sample distribution. It does **not** contain the private production obfuscator source.

Your script's required APIs must exist in the target environment. Test the protected output in that environment before distributing it.

## Privacy and policies

Submitted source is processed to produce protected output rather than retained as a source archive. Account activity stores job metadata; Discord and other providers have their own data handling. Only submit code you own or are authorized to process.

[Terms of Service](https://voltils.cc/tos/) · [Privacy Policy](https://voltils.cc/privacy/) · [Use Policy](https://voltils.cc/use-policy/)
