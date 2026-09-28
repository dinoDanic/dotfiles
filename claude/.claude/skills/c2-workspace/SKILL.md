---
name: c2-workspace
description: Maps the C2 (C2Connection) workspace — the Next.js frontend, the Elixir GraphQL backend and the legacy ASP.NET app — which one is editable, how data reaches the frontend (GraphQL vs c2-fetch vs iframe), and how the GraphQL contract and codegen flow between repos. Use before implementing any C2 frontend feature and whenever a repo path, GraphQL operation, resolver or legacy page needs to be located. Triggers: "implement X", "build X", "napravi X", "add widget", "where is X", "gdje je X", "why is codegen failing", "is that resolver deployed", "pull master", "sync repove", plus mentions of c2, C2Connection, c2_connect_frontend, c2_connect_backend, c2_ASPNET_facelift, Zvonimir, dev-api.c2-apps.com, iframe/legacy pages, wizard, PrismHR.
---

# C2 Workspace

Three repos, one product. Dino works on the **frontend**. Never guess a path — this map is authoritative.

## The three repos

| Repo | Path | What it is |
|---|---|---|
| **frontend** | `/home/dino/kodius/c2/c2_connect_frontend/` | Next.js 15 + React 19 + TS. **Where work lands.** Own git repo, `master`. |
| **backend** | `/home/dino/kodius/c2/c2_connect_backend/` | Elixir/Phoenix + Absinthe GraphQL. The API the FE talks to; it calls the legacy app internally. Zvonimir's side. |
| **legacy** | `/home/dino/kodius/c2/c2_ASPNET_facelift/` | .NET Framework 4.8 MVC 5 + Razor + jQuery, MSSQL. The old app, still authoritative for un-migrated features. |

Parent `/home/dino/kodius/c2/` is a plain folder, not a repo — so **the frontend's
`CLAUDE.md` does not auto-load from here.** Read these before FE work:
`c2_connect_frontend/CLAUDE.md` (architecture, conventions, key files),
`AGENTS.md` (code style), `SYSTEM-ARCHITECTURE.md` (the multi-system flow).

**C2 is** a bookkeeping / HR-benefits platform: onboarding, document wizards,
benefits enrollment, payroll (PrismHR), ACA compliance.

## Edit boundaries

- **frontend** — editable, this is the work.
- **backend** — read-only reference. Read schemas/resolvers to learn the contract;
  if something is missing, report it (it's Zvonimir's), don't implement it.
- **legacy .NET** — read-only *by default*. Narrow exceptions Dino does make:
  iframe query params that hide legacy chrome, commenting out home-dashboard tiles
  replaced by native widgets. Say what you'd touch before touching it.

## Sync before you read code

Backend and legacy move under you — Zvonimir merges to `master` daily. **Before reading
any backend schema/resolver or legacy controller/view, and before concluding something
doesn't exist, refresh all three checkouts:**

```bash
for r in c2_connect_frontend c2_connect_backend c2_ASPNET_facelift; do
  d=/home/dino/kodius/c2/$r
  git -C "$d" fetch origin --quiet
  if [ -z "$(git -C "$d" status --porcelain)" ] \
     && [ "$(git -C "$d" rev-parse --abbrev-ref HEAD)" = master ]; then
    git -C "$d" merge --ff-only origin/master --quiet
  fi
  echo "$r: $(git -C "$d" rev-parse --abbrev-ref HEAD), \
$(git -C "$d" rev-list --count HEAD..origin/master) behind origin/master"
done
```

- Fetch always; fast-forward **only** a clean checkout sitting on `master`. Never stash,
  reset, checkout or merge over Dino's work — the frontend is usually on a feature branch
  with uncommitted changes.
- If a repo reports it's behind (dirty, or on a branch), read the fresh code straight from
  the remote ref instead: `git -C <repo> show origin/master:<path>`,
  `git -C <repo> grep <pattern> origin/master -- <dir>`,
  `git -C <repo> log --oneline HEAD..origin/master`.
- Run this once per session, not per file. Skip it only for pure frontend-local questions.

## Three ways data reaches the frontend

Pick in this order:

1. **GraphQL → Elixir** (default for everything new). `features/<name>/<name>.graphql`
   + `api-hooks.ts` / `api-server.ts`, clients in `lib/graphql-request/`.
2. **`lib/c2-fetch`** — direct REST call to legacy .NET from the browser
   (`c2Get`/`c2Post`/`c2GetPdf`, cookie auth). Only where no GraphQL field exists.
   Never raw `fetch` at the .NET domain.
3. **iframe** — `_routes_for_real.frame("/Legacy/Path")` → `DynamicIframe`.
   Last resort, for pages not yet migrated. Cross-frame signals come over
   postMessage (wizard completion) — see [REFERENCE.md](REFERENCE.md).

## GraphQL contract + codegen

```
backend lib/graphql/schemas/*.ex + lib/c2_web/resolvers/*_resolver.ex   # the contract
  → deployed to https://dev-api.c2-apps.com/api/graphiql
  → FE: pnpm types    (codegen.ts → gql/generated/, from features/**/*.graphql)
```

- `pnpm types` reads the **deployed dev API** — that schema is the source of truth
  for what the FE can call today.
- Merged-but-undeployed backend work: after the sync above, check `git log HEAD..origin/master`
  (or `origin/master` itself) **before** claiming a resolver doesn't exist. To codegen against it, run the BE locally
  (`pnpm types_local`) or dump SDL from the checkout and point `CODEGEN_SCHEMA` at the file.
- Validation rules follow the Elixir contract (`non_null` = required), not legacy .NET client rules.

## Working a frontend feature

1. **Sync the repos** (above), then **find the contract** — grep
   `c2_connect_backend/lib/graphql/schemas/` and the matching `*_resolver.ex` for the
   query/mutation, its args and nullability.
2. **Find the FE precedent** — `ls c2_connect_frontend/features/`. Widgets, wizard flows and
   payroll panels all have siblings; copy the closest one's shape rather than inventing.
3. **Build it** in `features/<name>/` per that repo's `CLAUDE.md` layout; register routes in
   `lib/routes.ts` and query keys in `lib/react-query/query-keys.ts`.
4. **Verify at a milestone**, not per edit: `pnpm types` → `pnpm type-check` → `pnpm lint`.

## Migration status

Native: auth/MFA, home (widget-based), documents hub, forms, wizard, search,
profile & security, navigation, inbox, schedule, performance reviews, payroll sub-pages.
Still iframe: Prism payroll portals, W-2s, time-off, my-options / administrative-options,
most legacy admin. Home is being widget-ified — legacy tiles get commented out as native
widgets land.

Deeper directory maps, URLs, env vars, the auth/cookie chain and the postMessage
protocol: [REFERENCE.md](REFERENCE.md).
