# Voltfuscator

[![Voltfuscator animated demo](source/Voltfuscator/assets/voltfuscator-demo.gif)](https://voltils.cc/)

Voltfuscator is a hosted Lua 5.1 and Luau obfuscation service maintained by **Voltils**. It increases the effort required to inspect or reconstruct scripts while preserving their intended behavior.

Updated **October 16, 2026** for the current **Voltfuscator 7.7** release.

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

| Tier | Per rolling 12 hours | Maximum per day (UTC) | Source limit |
| --- | ---: | ---: | ---: |
| Basic | **3** | **6** | **256,000 characters** |
| Pro | **12** | **24** | **5,000,000 characters** |
| Elite | **120** | **240** | **10,000,000 characters** |

Website, bot, and API builds share the same account allowance. Creating more keys does not increase it. Each rolling-window slot returns 12 hours after its successful build completes. Daily caps reset at **00:00 UTC**; this does not clear builds still inside the rolling 12-hour window. Failed builds do not consume successful-build quota. Pending jobs temporarily reserve a slot.

## Website

1. Open [the dashboard](https://voltils.cc/dashboard/#obfuscate) and sign in with Discord.
2. Paste your Lua or Luau source.
3. Select **Normal** or **Max**, choose **Lua 5.1** or **Executor / Luau** for your host, then obfuscate.
4. Copy or download the output before leaving the workspace.

## Discord bot

Join the [Discord server](https://discord.gg/78yYmtaeg4), then DM the bot a `.lua` or `.txt` attachment. Its panel lets you choose Normal or Max and review protection options. Select **Next**, then choose **Lua 5.1** or **Executor / Luau** to start the build.

- Accept the Terms of Service and Privacy Policy when prompted.
- A Discord status requirement is optional; follow the bot's instructions if the server enables it.
- The bot has a **10-minute cooldown** per user.
- Anti-tamper starts enabled for new sessions.
- Optional Anti-HTTP Spy is available through the bot panel for compatible runtimes.
- Successful jobs use your shared Basic, Pro, or Elite quota.
- Account-update DMs are sent only for actual tier upgrades. Downgrades and unchanged tiers do not send an account-update DM; existing API keys remain active.

## Macros

The supported macro families are **VLT**, **MV**, and **LPH**. Use any of these
names with an inline function:

| Voltfuscator | MV equivalent | LPH equivalent | Execution |
| --- | --- | --- | --- |
| `VLT_JIT` | `MV_JIT` | `LPH_JIT` | Faster virtualized function profile. |
| `VLT_JIT_MAX` | `MV_JIT_MAX` | `LPH_JIT_MAX` | Lightest virtualized function profile. |
| `VLT_NO_VIRTUALIZE` | `MV_NO_VIRTUALIZE` | `LPH_NO_VIRTUALIZE` | Native function; bypasses VM dispatch. |

`JITMAX` is accepted as an alias for `JIT_MAX` in each family.

```lua
local calculate = VLT_JIT_MAX(function(count)
    local total = 0
    for i = 1, count do total = total + i end
    return total
end)

game:GetService("RunService").Heartbeat:Connect(VLT_NO_VIRTUALIZE(function(dt)
    -- Frequently called work.
end))
```

These are real per-function choices in Normal and Max. Captured locals keep live
reads and writes, including callbacks used after the main script returns. Pass an
inline function; reflective environment/debug access in marked functions is
unsupported. Native Lua 5.1 functions require Lua 5.1 syntax.

Performance profiles trade protection for speed. Native functions bypass VM
protection, and JIT functions use lighter protection. Unmarked functions keep
their selected preset. Speedups depend on the workload; captured-variable access
can remain expensive. These are compilation profiles, not a hardware JIT.

Value and check helpers include `VLT_OBFUSCATED`, `VLT_LINE`, `VLT_ENC_STR`,
`VLT_ENC_NUM`, `VLT_ENC_FUNC`, `VLT_ASSERT`, `VLT_PRECHECK`, `VLT_REWRITE`, and
`VLT_CRASH`, with supported MV/LPH equivalents. See the
[macro documentation](https://voltils.cc/docs/#macros) for accepted arguments,
aliases, migration hints and limitations.

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
  "preset": "max",
  "runtime": "lua51"
}
```

Successful response:

```json
{
  "success": true,
  "obfuscated": "<protected Lua output>"
}
```

`code` must be nonempty UTF-8 source. `preset` accepts `normal` or `max` and defaults to `normal`. `runtime` accepts `lua51`, `luau`, or `executor`; omitting it defaults to `luau`. Use `executor` for Roblox/executor output with environment checks requiring Roblox APIs and `getgenv()`. Standard `lua51` and `luau` modes do not require those executor APIs. Account usage metadata is returned in the `X-Voltfuscator-Usage` response header. `GET https://voltils.cc/v1/obfuscate` returns service and tier information; it does not compile a script.

The old `api.voltils.nxtdev.xyz` URL is not the endpoint documented for current clients.

### Limits and errors

- Source size: **256,000 characters for Basic**, **5,000,000 for Pro**, and **10,000,000 for Elite**. Unicode characters are counted as code points.
- Compiler budget: **60 seconds** per build.
- One active job per account; the compiler also has one processing slot.
- An interrupted connection can leave a reservation pending for up to **90 seconds**. A success already confirmed still counts.
- `400`: invalid request, preset, or runtime; `401`: invalid, expired, or revoked credentials; `413`: invalid source size; `429`: quota, attempt limit, or compiler busy; `5xx`: temporary service/compiler failure.

Follow retry guidance when rate-limited or busy. Limits may change; the live dashboard and documentation are the current reference.

## Included examples

`example.source.lua` is the readable input. `example.lua` was regenerated on October 16, 2026 with the current Max compiler, Executor / Luau runtime checks, and anti-tamper enabled. Both print:

```text
Hello from Voltfuscator!
```

```text
README.md                      Service and API documentation
example.source.lua             Readable example input
example.lua                    Max protected output
source/Voltfuscator/vm.lua      Source-availability notice
```

The protected sample requires a compatible Roblox executor with Roblox APIs and `getgenv()`. Keep its generated formatting intact. `source/Voltfuscator/vm.lua` is a source-availability notice. For standard Lua 5.1 or standalone Luau, generate output with the matching runtime in the service.

## Compatibility and source availability

This package is a public information and output-sample distribution. It does **not** contain the private production obfuscator source.

Your script's required APIs must exist in the target environment. Test the protected output in that environment before distributing it.

## Privacy and policies

Submitted source is processed to produce protected output rather than retained as a source archive. Account activity stores job metadata; Discord and other providers have their own data handling. Only submit code you own or are authorized to process.

[Terms of Service](https://voltils.cc/tos/) · [Privacy Policy](https://voltils.cc/privacy/) · [Use Policy](https://voltils.cc/use-policy/)
