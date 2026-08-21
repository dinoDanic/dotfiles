# Kloki Workspace — Directory Reference

Per-repo maps. Paths are relative to each repo root unless stated otherwise.

---

## kloking-core — web monorepo

Root: `/home/dino/kodius/kloki/kloking-core/`
pnpm workspaces + turbo. Root `CLAUDE.md` covers OpenAPI regeneration, feature
folder rules and i18n rules.

### Apps

| App | What it is |
|---|---|
| `apps/users/` | **The web app.** Next.js 16 + React 19, App Router, `basePath: /app`, standalone output. This is what mobile mirrors. |
| `apps/shepard/` | Internal customer-success / lifecycle app. Reads the shared `klokking-token` session, calls the boro `api/shepard` namespace. Never part of the client-facing bundle. |
| `apps/docs/` | Static help site (Next.js + Nextra), served at `help.kloki.app`, independent of `apps/users`. |
| `apps/web/`, `apps/web-hr/` | Public marketing / landing sites. |

### Shared packages

| Package | Contains |
|---|---|
| `packages/ui` | Radix/shadcn-style component library (primitives, shadcn, typography) |
| `packages/configs` | ESLint 9 flat config, TypeScript, Tailwind, Prettier configs |
| `packages/timetracker` | Time tracking module |
| `packages/marketing`, `packages/free-tools` | Marketing-site building blocks |

### Inside `apps/users/`

| Path | Contains |
|---|---|
| `CLAUDE.md` | Architecture, commands, routing — read this first |
| `features/{name}/` | Domain modules. Only these sections are allowed inside: `components/`, `helpers/`, `hooks/`, `types/`, `context/`, `utils/`, `actions/` |
| `app/` | Route files only (`page.tsx`, `layout.tsx`, `loading.tsx`, `error.tsx`, `not-found.tsx`) |
| `api/fns/{domain}/` | API call functions by domain |
| `api/keys.ts` | React Query cache keys |
| `api/clients/` | Request factories (`client_request.ts`, `server_request.ts`) |
| `components/` | Shared UI |
| `hooks/`, `lib/`, `helpers/`, `utils/` | Cross-feature code |
| `i18n/messages/index.ts` | All HR + EN strings. User-facing text is **never** hardcoded |
| `schema.d.ts` | Generated OpenAPI types — regenerate, don't hand-edit |

### Route groups

- `/auth/*` — public auth (login, register, sign-up, msal-callback)
- `/core/my-panel/*` — user views (dashboard, entry-hours, new-request, notifications, settings)
- `/core/manage/*` — manager views (absences, time-entries, shift-schedule, travel-orders)
- `/core/administration/*` — admin views (employees, clients, projects, settings)
- `/core/wizard/*` — onboarding wizard

### Commands (from `apps/users/`)

```bash
pnpm dev              # dev server on :3001
pnpm check            # tsc type-check
pnpm test             # vitest
pnpm e2e              # Playwright UI
pnpm generate         # regenerate schema.d.ts from dev API
pnpm generate_local   # regenerate from localhost:4000
```

---

## boro — Rails backend

Root: `/home/dino/kodius/kloki/boro/`
Serves every client. Its `CLAUDE.md` documents testing rules, the swagger
workflow and domain-specific schemas.

| Path | Contains |
|---|---|
| `config/routes.rb` | All endpoints — start here when hunting an API path |
| `app/controllers/` | Request handling, params, authorization |
| `app/models/` | Records, associations, validations |
| `app/serializers/`, `app/views/` | Response shapes |
| `app/services/`, `app/interactors/` | Business logic |
| `app/jobs/`, `app/notifications/`, `app/mailers/` | Async work, push/email |
| `app/admin/` | Admin panel |
| `spec/swagger_helper.rb` | **Hand-edited** OpenAPI schema definitions |
| `openapi/v1/openapi.json` | Generated spec — never edit manually |

### Commands

```bash
make test                    # full suite (parallel_tests — never run rspec directly)
make test SPEC=spec/services/foo_spec.rb
make test SPEC="spec/services/foo_spec.rb:42"
make swagger                 # regenerate openapi/v1/openapi.json
```

---

## kloki-mobile — React Native / Expo

Root: `/home/dino/kodius/kloki/kloki-mobile/`
Its `CLAUDE.md` points at `.kai/*.md` convention files (project structure, React,
types, React Native, forms, layout primitives) — read the relevant one before writing code.

| Path | Contains |
|---|---|
| `app/` | expo-router routes |
| `features/{name}/` | Domain modules, named to match the web feature folder |
| `components/` | Shared UI |
| `hooks/`, `lib/` | Cross-feature code (`lib/api`, `lib/i18n`, `lib/env.ts`) |
| `modules/`, `plugins/` | Native modules and Expo config plugins |
| `schema.d.ts` | Its own generated copy of the OpenAPI types |
| `scripts/`, `fastlane/`, `DEPLOY.md` | Build and release |

`android/` and `ios/` exist locally as prebuild output but are not committed —
native work goes through `modules/*` and config plugins.

### Commands

```bash
pnpm start            # Metro
pnpm ios / pnpm android
pnpm typecheck
pnpm generate         # regenerate schema.d.ts from dev API
pnpm deploy           # scripts/deploy.sh (fastlane + source maps)
```
