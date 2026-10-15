# HappyMonk3y's Client Scanner

A console prop for scripted YouTube videos. All scan messages and results are fictional. It does not inspect Java, processes, memory, files, or the network, and it cannot detect cheating.

## Run locally

Open PowerShell in this folder and run:

```powershell
& .\happymonk3y-client-scanner.ps1
```

Each run randomly takes 27-120 seconds, displays a different selection of progress messages, then shows a colored report. Administrator access is not required.

The console uses a bordered header, timestamped progress lines, a filling progress bar without a time-remaining estimate, grouped client/macro/module results, colored status badges, and a final summary. The bar stays fully filled at 100% when the scan completes.

## Results

Each run randomly selects one client and always gives that client a `FLAG` result with exactly one occurrence:

- 198m Client
- Prestige Client
- Doomsday Client
- Krypton Client
- Argon Client

Anchor Macro and Double Anchor each show exactly one occurrence. Their results randomly receive `FLAG`, `GENERIC`, or `FALSE POSITIVE`.

The following modules each show 1-30 occurrences and randomly receive `FLAG`, `GENERIC`, or `FALSE POSITIVE`:

- Auto Crystal
- Auto Hit Crystal
- Shield Breaker
- Hover Totem
- Auto Totem
- Inv Totem
- Totem Refill
- Fast Place

## Run from GitHub

Paste this command into PowerShell or the Windows Run dialog:

```powershell
powershell -NoProfile -NoExit -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/HappyMonk3y/happymonk3y-client-scanner/main/happymonk3y-client-scanner.ps1' -ErrorAction Stop)"
```

The command fetches the script and runs it in a new PowerShell session without a manual download. The session stays open so the results remain visible. It requires internet access.

## Quick preview

Use a shorter duration when rehearsing:

```powershell
& .\happymonk3y-client-scanner.ps1 -DurationSeconds 1
```

Omit that parameter to restore the random 27-120 second duration.
