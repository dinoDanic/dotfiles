# C2 Workspace Reference

## URLs & environments

| What | Where |
|---|---|
| FE dev server | `http://localhost:3640/app` (basePath `/app`, Turbopack) |
| Elixir dev API | `https://dev-api.c2-apps.com/api/graphiql` (also GraphiQL UI) |
| Elixir local | `http://localhost:4000/api/graphiql` |
| Legacy .NET dev | `https://c2-connect-dev.kodius.com` (FE reads it as `c2root`) |

Key env vars: `GRAPHQL_API` / `NEXT_PUBLIC_GRAPHQL_API` (Elixir endpoint),
`NEXT_PUBLIC_C2ROOT` (legacy base — never hardcode, use `c2root` from
`features/user/options.ts`), `CODEGEN_SCHEMA` (codegen override),
`HONEYBADGER_API_KEY` + `NEXT_PUBLIC_ENV` (error reporting).
Backend-only: `DB_ENCRYPTION_KEY` (Cloak vault), `SECRET_KEY_BASE`, `C2_SQL_DB_*`,
`C2_HTTP_LEGACY_BASE_URL`, `C2_ASPNET_API_BASE_URL`, `TWILIO_*`, `AWS_SES_*`.

## Frontend layout (`c2_connect_frontend/`)

```
app/                 # App Router. app/auth/* public, app/secure/* guarded, app/api/{health,build}
features/<name>/     # ~50 features: api-hooks.ts, api-server.ts, <name>.graphql,
                     # query-keys.ts, options.ts, components/, hooks/, store/, types/, helpers/
components/ui        # shadcn-based primitives (+ ui-remastered)
components/form      # RHF-bound FormInput / FormRadio / FormSelect / FormAttachments / ...
components/blocks    # Grid, Stack, Cluster, Split, Switcher, ShowHide
components/layouts   # page layouts    components/listeners  # PostMessageListener
lib/routes.ts        # _routes + _routes_for_real
lib/graphql-request/ # _client, _serverClient, _cachedClient
lib/react-query/     # query-client.ts (retry 0), query-keys.ts registry
lib/c2-fetch/        # direct .NET REST client
lib/cookies/         # _cookiesNames + server actions   lib/dot-net-session/, lib/zod/, lib/honeybadger/
gql/generated/       # codegen output — never hand-edit
middleware.ts        # route guard on the session cookie
```

Feature families worth knowing: `*-widget` (home dashboard cards), `wizard` +
`documents*` + `forms*` (document signing flow), `my-payroll` / `payroll` / `paychecks-widget`
(PrismHR), `auth` + `mfa` + `sessions`, `admin` / `client-dashboard` / `ai-*`.

## Backend layout (`c2_connect_backend/`)

```
lib/graphql/schemas/*.ex      # query/mutation definitions — read these for the contract
lib/graphql/types/            # object + input types
lib/graphql/middlewares/      # auth enforcement (all ops authed except a whitelist)
lib/c2_web/resolvers/*.ex     # resolver implementations (+ resolvers/admin, resolvers/auth)
lib/c2_api/                   # adapters; http_legacy.ex + asp_net_api.ex are the .NET bridges
lib/schemas/legacy_mssql/     # Ecto models over the legacy MSSQL DB
lib/services/                 # auth, documents, PDF, MFA, Elasticsearch, Jira, tokens
lib/core/                     # enums (content_item_category, document_status, field_type, ...)
```

Dev commands (Elixir 1.18.3 / Erlang 27.3 per `.tool-versions`): `make compile`,
`make dev`, `make test`, `make check`, `make format`. Route: `POST /api/graphql/`.
`C2.DecRepo` wraps `C2.MssqlRepo` with automatic field encryption/decryption (SSN, email,
passwords) via Cloak AES-GCM.

## Legacy layout (`c2_ASPNET_facelift/`)

26 projects; the ones that matter for FE work:

- `C2Connection.WebV2/` — the MVC app the iframes render. `Controllers/` (40+ MVC
  controllers plus `Controllers/V2` REST API used by Elixir/Next.js),
  `Views/{Portal,ContentItem,Payroll,Client,Enrollments,...}/`.
- `C2Connection.Data/` — domain models + data access. `C2Connection.Core/` — DB abstraction,
  encryption. `C2Connection.PrismHR/` — payroll integration.

FE-adjacent touch points: `Views/Portal/Index.cshtml` (legacy home tiles being replaced by
native widgets), `Views/Shared/_WizardButtons.cshtml` (postMessage on last step),
`Helpers/CompleteOnlineHelper.cs` (last-step detection), iframe params that hide legacy
chrome (e.g. `hideDocumentActions`).

## Auth & cookie chain

1. Login (MSAL/Azure or username+password) → Elixir issues a JWT session, FE stores it in
   the `c2Session` cookie.
2. Elixir also performs a **silent login** against .NET and passes back its cookies
   (`.ASPXAUTH`, `.AspNet.ApplicationCookie`, `ASP.NET_SessionId`), rewritten to
   `Domain=.kodius.com; SameSite=None; Secure`.
3. That is what authorizes **iframes** and **c2-fetch** — GraphQL uses the bearer token,
   the legacy calls ride the cookies.
4. FE server helpers: `_getSession()`, `_requireMe()`, `_requireAccountProfile()`,
   `_requireClientProfile()` in `features/user/api-server.ts`. The browser GraphQL client
   auto-logs-out on `Unauthenticated` / `Invalid credentials` — don't hand-handle it.
5. MFA: TOTP, email, and SMS (Twilio); remember-device token kept in a cookie.

## PostMessage protocol (iframe → Next.js)

Legacy wizard signals document completion so Next.js can drive inter-document flow:

```
{ type: 'document_completed', wizardId, contentItemId, documentName,
  wizardNumber, wizardCount, accountProfileId, packageId }
```

.NET handles navigation *within* a multi-step document; Next.js handles moving
*between* documents. Handled by `components/listeners/PostMessageListener`.
Note: the listener historically does not verify `event.origin` — treat payloads as untrusted.

## Data flow, end to end

```
Next.js  ──GraphQL──▶ Elixir/Absinthe ──▶ C2Api adapters ──▶ ASP.NET API ──▶ MSSQL
                              └────────── Ecto/DecRepo ─────────────────────▶ MSSQL
Next.js  ──c2-fetch (cookies)──▶ ASP.NET REST
Next.js  ──iframe──▶ ASP.NET MVC (Razor) ──postMessage──▶ Next.js
```
