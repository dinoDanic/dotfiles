---
name: see-kloki-web-app
description: Explore the existing Kloki web app (Next.js) to guide React Native mobile development. Use BEFORE implementing any mobile feature — the web app is the source of truth for logic and APIs. Triggers: "implement X", "build X feature", "napravi X", "add X to mobile" (any feature work), plus "check the web app", "how does X work on web", "see kloki web", "reference web app".
---

# See Kloki Web App

The Kloki web app is the **source of truth** for all feature logic. Whenever a feature is being added to mobile, first locate and read its web implementation, then mirror the logic in the mobile codebase. Do not invent new logic on the mobile side.

Typical request shape: *"Implement gantt feature — on web it's at X, implement it in mobile."* Even when the user doesn't give paths, assume the web has a reference implementation and find it.

## Repo Locations

- **Web monorepo root:** `/home/dino/kodius/kloking-core/`
- **Web app (Next.js):** `/home/dino/kodius/kloking-core/apps/users/`
- **Mobile app (React Native / Expo):** `/home/dino/kodius/kloki/kloki-mobile/`
- **Backend (Ruby on Rails):** `/home/dino/kodius/kloki/boro/`

## Feature Folder Mapping

Mobile and web feature folders share names by convention:

| Web | Mobile |
|---|---|
| `kloking-core/apps/users/features/{name}/` | `kloki-mobile/features/{name}/` |

When implementing a feature on mobile, target `kloki-mobile/features/{name}/` using the same `{name}` as the web folder (e.g. web `absences-gantt` → mobile `absences-gantt`). If a similar folder already exists with a slightly different name, prefer the existing mobile name over creating a duplicate.

## Key Directories

| Directory | Contains |
|---|---|
| `features/{name}/` | Domain-scoped modules (components, stores, hooks, logic) |
| `api/fns/{domain}/` | API call functions organized by domain |
| `api/keys.ts` | React Query cache key definitions |
| `api/clients/` | Request factories (client_request.ts, server_request.ts) |
| `components/` | Shared reusable UI components |
| `hooks/` | Custom React hooks |
| `lib/` | Utility libraries (zod, date helpers, etc.) |
| `i18n/messages/index.ts` | All translation strings (HR + EN) |
| `schema.d.ts` | Auto-generated OpenAPI types (the API contract) |

## Workflow

When invoked with `ARGUMENTS`:

1. **Read the web app CLAUDE.md** for overall architecture context:
   - `Read ~/dino/kodius/kloking-core/apps/users/CLAUDE.md`

2. **Identify what to explore** based on the argument:
   - Feature name (e.g., "entry-hours") -> explore `features/{name}/`
   - API domain (e.g., "timetracker API") -> explore `api/fns/{domain}/`
   - Types (e.g., "request types") -> search `schema.d.ts` and feature types
   - Hook (e.g., "useMe hook") -> explore `hooks/` and feature hooks
   - General (e.g., "how auth works") -> follow the architecture docs

3. **Explore the relevant code:**
   - Read the main files in the target area
   - Look at API calls to understand endpoint patterns and payloads
   - Look at types to understand data shapes
   - Look at business logic (validation, transforms, state management)
   - Look at i18n keys used for the feature

4. **Report findings** structured as:
   - **Web source** - path to the web feature folder being mirrored
   - **Mobile target** - path under `kloki-mobile/features/{name}/` where this should be implemented
   - **API endpoints used** - paths, methods, request/response types
   - **Key types** - data shapes the mobile app will need
   - **Business logic** - validation rules, transforms, state flows
   - **Query keys** - cache key patterns from `api/keys.ts`
   - **i18n keys** - translation keys to reuse or mirror
   - **Mobile considerations** - what translates directly vs. needs adaptation

## When the web doesn't have what you need

`schema.d.ts` is auto-generated from the backend's OpenAPI spec, so most API contracts can be answered from the web side. If something is missing or unclear (an endpoint not in `schema.d.ts`, a payload shape, validation rules, error responses), drop into the Rails backend at `/home/dino/kodius/kloki/boro/`:

- Routes: `boro/config/routes.rb`
- Controllers: `boro/app/controllers/`
- Models / validations: `boro/app/models/`
- Serializers (response shapes): `boro/app/serializers/` or `boro/app/views/`

Only go to `boro` after the web side has been checked — the web's usage of an endpoint is usually the fastest answer.

## When invoked without arguments

List available features and API domains so the user can pick what to explore:
```
ls ~/dino/kodius/kloking-core/apps/users/features/
ls ~/dino/kodius/kloking-core/apps/users/api/fns/
```

## Important Notes

- The web app uses **openapi-fetch** with types from `schema.d.ts` - the mobile app will hit the same API
- The web app uses **Next.js App Router** patterns - adapt server components to React Native equivalents
- Translation keys in `i18n/messages/index.ts` should be mirrored in the mobile app's i18n setup
- React Query patterns (keys, invalidation) should stay consistent between web and mobile
