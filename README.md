# happymonk3y client scanner

A console prop for scripted YouTube videos. All scan messages and results are fictional. It does not inspect Java, processes, memory, files, or the network, and it cannot detect cheating.

## Run locally

Open PowerShell in this folder and run:

```powershell
& .\happymonk3y-client-scanner.ps1
```

The default run displays scan progress for 120 seconds, then a colored report. Administrator access is not required.

## Results

Each run randomly selects one client and always gives that client a `FLAG` result:

- Prestige Client: 1-20 occurrences.
- Krypton Client: 1-30 occurrences.
- Doomsday Client: 1-30 occurrences.

The other checks each show 1-30 occurrences and randomly receive `FLAG`, `GENERIC`, or `FALSE POSITIVE`:

- Auto Crystal
- Auto Hit Crystal
- Anchor Macro
- Double Anchor
- Shield Breaker
- 198m
- Hover Totem
- Auto Totem
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

Omit that parameter to restore the two-minute run.
