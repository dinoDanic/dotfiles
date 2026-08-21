---
name: kloki-workspace
description: Maps the Kloki workspace — where the web app, mobile app and Rails backend live, which one is the source of truth, and how the shared OpenAPI contract flows between them. Also drives the workflow for mirroring a web feature into mobile. Use before implementing any Kloki feature, and whenever a repo path, API endpoint or type definition needs to be located. Triggers: "implement X", "build X", "napravi X", "add X to mobile" (any feature work), "where is X", "gdje je X", "check the web app", "how does X work on web", plus mentions of boro, kloking-core, apps/users, schema.d.ts, the backend, or the API.
---

# Kloki Workspace

Three repos, one product, one API. Never guess a path — this map is authoritative.

## The three repos

| Repo | Path | What it is |
|---|---|---|
| **boro** | `/home/dino/kodius/kloki/boro/` | Ruby on Rails backend. The API every client talks to. |
| **kloking-core** | `/home/dino/kodius/kloki/kloking-core/` | pnpm + turbo monorepo. The **web app is `apps/users/`**. |
| **kloki-mobile** | `/home/dino/kodius/kloki/kloki-mobile/` | React Native / Expo app. Where mobile work gets committed. |

The parent `/home/dino/kodius/kloki/` is a plain folder, not a git repo. Each of
the three is its own repo with its own `CLAUDE.md` — read the relevant one before
working in it.

Frequent mistake: `/home/dino/kodius/kloking-core/` (missing `/kloki/`) **does not exist**.

## Web is the old one, mobile is the new one

`apps/users` has been in production for years, so it is the **source of truth for
feature logic** — business rules, validation, endpoint usage, i18n wording.
`kloki-mobile` is new and mirrors it. Don't invent logic on the mobile side; find
the web implementation first and adapt it to React Native patterns already
established in the mobile repo. Never copy web code verbatim.

For the **API contract** (payload shapes, error responses, permissions), boro is
the source of truth — but check the web's usage first, it's usually the faster answer.

## Edit boundaries

- **kloki-mobile** — editable, this is where mobile work lands.
- **kloking-core** and **boro** — treat as read-only reference. If a bug or a
  missing endpoint is found there, **report it, don't fix it**, unless the user
  explicitly asks for the change.

## The API contract flow

All clients hit the same Rails API and share one generated type file:

```
boro/spec/swagger_helper.rb        # hand-edited schema definitions
  → make swagger                   # regenerates the spec
  → boro/openapi/v1/openapi.json   # NEVER edit by hand
  → served at /api-docs/v1/openapi.json
  → pnpm generate                  # in apps/users AND in kloki-mobile
  → schema.d.ts                    # one copy per frontend
```

- `pnpm generate` → dev API (`https://dev-api.kloki.app`)
- `pnpm generate_local` → local backend (`http://localhost:4000`)
- Both frontends call the API with **openapi-fetch** typed from their own `schema.d.ts`.
- A backend field change means: edit `swagger_helper.rb` → `make swagger` → regenerate
  `schema.d.ts` in *both* frontends that need it.

## Feature folders map 1:1

Web and mobile feature folders share names by convention:

| Web | Mobile |
|---|---|
| `kloking-core/apps/users/features/{name}/` | `kloki-mobile/features/{name}/` |

e.g. web `absences-gantt` → mobile `absences-gantt`. If a similar mobile folder
already exists under a slightly different name, use the existing one rather than
creating a duplicate.

## Workflow: mirroring a web feature into mobile

1. **Locate the web feature** — `ls kloking-core/apps/users/features/` and read the
   matching folder. Assume a reference implementation exists even when the user
   gives no path.
2. **Read the code that matters** — components for structure, `api/fns/{domain}/`
   for endpoints, `api/keys.ts` for React Query keys, feature `types/` and
   `schema.d.ts` for shapes, `i18n/messages/index.ts` for wording.
3. **Drop into boro only if the web can't answer** — routes, controllers, models,
   serializers (see [REFERENCE.md](REFERENCE.md)).
4. **Report before building**: web source path · mobile target path · endpoints
   (method, path, request/response types) · key types · business logic and
   validation · query keys · i18n keys · what needs adapting for React Native.
5. **Implement in `kloki-mobile/features/{name}/`**, following that repo's
   `CLAUDE.md` and its `.kai/*.md` convention files.

## Deeper directory maps

Per-repo directory guides (web app, backend, mobile, other monorepo apps and
shared packages): see [REFERENCE.md](REFERENCE.md).
