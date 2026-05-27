---
name: sync-rn-deploy
description: Sync the React Native fastlane deploy setup (Fastfile + scripts/deploy.sh) from a reference project into the current project, copying logic while preserving project-specific values (APP_ID, ENV variable names, team_id, Play Store tracks, TestFlight groups, app-name strings). Use when the user invokes /sync-rn-deploy, asks to "update/sync/refresh my deploy script", or says they have a newer deploy setup in another RN project they want to mirror into this one.
---

# sync-rn-deploy

Mirror the deploy LOGIC from a source RN project into the current project, without overwriting values that are specific to this project.

## Inputs

- `$1` — path to the source mobile-project root (the one with the latest/best deploy setup). It must contain `fastlane/Fastfile` and `scripts/deploy.sh`.
- CWD — the **target** mobile-project root. If CWD isn't an RN mobile root (no `fastlane/Fastfile`), ask the user where the target is.

If `$1` points to a `fastlane/` folder or a monorepo root, walk up/down to find the mobile root that has `fastlane/Fastfile` + `scripts/deploy.sh` siblings.

## Files in scope

Sync:
- `fastlane/Fastfile`
- `scripts/deploy.sh`

Never touch:
- `fastlane/Appfile` (entirely project-specific: app_identifier, team_id)
- `fastlane/.env.example` and any `.env*` files
- `app.json`, `Gemfile`, etc.

## What to sync (logic)

- Helper-function signatures and bodies (`build_and_upload_ios`, `build_and_upload_android`): new parameters (`distribute:`, `changelog:`, `track:`), new ENV reads, new `UI.message` lines, new control flow.
- Version bumping, build-number / version-code computation (including multi-track scans).
- `build_app`, `upload_to_testflight`, `upload_to_play_store`, `gradle` call shapes — keys, defaults, conditional values.
- Lane structure: which lanes exist (`:open`, `:production`), how they parse `|options|` for `distribute`/`changelog`, how they pass labels through.
- `deploy.sh` flow: color helpers, platform/lane selection, distribute prompt, changelog prompt, confirmation step, run loop.

## What to preserve (project-specific — read from target, re-apply)

- `APP_ID` literal value.
- Every `ENV.fetch("…")` key name — including `EXPO_PUBLIC_*`, the json-key path var (e.g. `SUPPLY_JSON_KEY_FILEPATH` vs `GOOGLE_PLAY_JSON_KEY_PATH`), keystore vars.
- Play Store `track:` literal values per lane (`"internal"` vs `"beta"` vs `"production"`).
- TestFlight `groups:` literal array (e.g. `["open"]`).
- `env_label:` strings (`"dev"` vs `"staging"`) and any `desc` wording.
- Dotenv paths if the target uses different ones (e.g. monorepo `mobile/.env` vs flat `.env`).
- `deploy.sh` banner string (e.g. "Kloki Deploy" vs "Pokloni Deploy") and any other app-name UI text.

## New ENV vars the source introduces

If the source adds an ENV read that the target has no obvious counterpart for (e.g. source has `EXPO_PUBLIC_SOCKET_URL` but target only ever used a single API URL), STOP and ask the user:

- "Source reads `EXPO_PUBLIC_SOCKET_URL` — what's the equivalent in this project, or should I add it as-is and let you set it later?"

Never invent ENV names silently.

## Workflow

1. Resolve `$1` to source mobile root. Verify `fastlane/Fastfile` + `scripts/deploy.sh` exist there. If `deploy.sh` is missing, ask which script is the deploy script.
2. Read source Fastfile + deploy.sh and target Fastfile + deploy.sh.
3. Build a **preserve map** from the target: APP_ID, every ENV key, every `track:`/`groups:` literal, dotenv paths, env_label strings, desc strings, banner text.
4. Write new target files by taking source content and substituting the preserve map into the matching positions. Where a slot is new (source added it; target has no counterpart), follow the "new ENV vars" rule above; for new track/group literals, pick a sensible default and flag it.
5. If the source has lanes the target doesn't (e.g. Android `:production`), add them — but preserve target-style values inside (track name, env_label, dotenv path). Flag the addition.
6. If the target has lanes/features the source dropped, KEEP them. Never downgrade. Flag the divergence.
7. Print a concise summary: files changed, key logic added, preserved values used, anything you had to guess or skip.
8. Do NOT run `git add`/`git commit`. Let the user review the diff.

## Out of scope

- Not a generic ruby/bash linter — only port what the source actually has.
- Not a one-way clone — preserve target values, don't blindly overwrite.
- Don't edit anything outside `fastlane/Fastfile` and `scripts/deploy.sh` unless the user asks.
