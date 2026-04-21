---
name: see-kloki-web-app
description: Explore the existing Kloki web app (Next.js) to guide React Native mobile development. Use when user needs to reference the web app for feature logic, API calls, types, hooks, business rules, or UI patterns before implementing the mobile equivalent. Triggers: "check the web app", "how does X work on web", "see kloki web", "reference web app", or any task that needs web app context for mobile implementation.
---

# See Kloki Web App

Explore the production Kloki web app to extract patterns, types, API usage, and business logic for guiding mobile app development.

## Web App Location

- **Monorepo root:** `~/dino/kodius/kloking-core/`
- **Web app:** `~/dino/kodius/kloking-core/apps/users/`

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
   - **API endpoints used** - paths, methods, request/response types
   - **Key types** - data shapes the mobile app will need
   - **Business logic** - validation rules, transforms, state flows
   - **Query keys** - cache key patterns from `api/keys.ts`
   - **i18n keys** - translation keys to reuse or mirror
   - **Mobile considerations** - what translates directly vs. needs adaptation

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
