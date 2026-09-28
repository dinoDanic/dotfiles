---
name: prd-and-plan
description: Interviews the user, then writes both a PRD (prd/<slug>.md) and a phased tracer-bullet implementation plan (plans/<slug>.md) in a single pass, with one batched round of questions and no approval gate in between. Use when the user wants a feature specced end to end, mentions a PRD and a plan together, says "spec this out", "napravi PRD i plan", or invokes /prd-and-plan. Prefer this over running write-a-prd and prd-to-plan as two separate steps.
---

# PRD and Plan

One pass: interview, then write `prd/<slug>.md` and `plans/<slug>.md`. No approval gate between the two files. This skill produces documents only, it never writes implementation code.

## Process

### 1. Get the problem description

Ask for a long, detailed description of the problem and any solution ideas. Plain text ask, not `AskUserQuestion`. Skip this step if the invocation already carries enough detail.

### 2. Explore the codebase

Verify the user's assertions rather than trusting them. Find the current architecture, existing patterns, integration layers, and anything that contradicts what was described. If something contradicts it, say so in a sentence before continuing.

### 3. Interview once, in batches

Use `AskUserQuestion` for every design question. Never ask design questions as plain text.

- 2-4 labeled options per question, recommended option first with "(Recommended)" appended to the label
- `multiSelect: true` when the options are not mutually exclusive
- Up to 4 questions per call, grouped so related decisions get answered in one interaction
- Walk the whole decision tree in as few calls as possible. Only defer a question to a later call when an earlier answer genuinely changes what that question should be
- Ask about things that change what gets built. For plumbing with an obvious default, pick the default and record it under Implementation Decisions instead of asking
- Stop asking once nothing left would change the outcome

### 4. Write the PRD

Derive a kebab-case slug from the feature name. Create `prd/` if it does not exist. Write `prd/<slug>.md` using the PRD template in [TEMPLATES.md](TEMPLATES.md).

### 5. Write the plan, immediately

Do NOT ask for approval on the PRD. Do NOT present the phase breakdown for review. Go straight from the PRD to the plan file.

First fix the durable architectural decisions, the ones unlikely to change during implementation: route structures, database schema shape, key data models, auth approach, third-party service boundaries. These go in the plan header so every phase can reference them.

Then break the work into tracer bullet phases:

- Each phase is a thin vertical slice through ALL layers (schema, API, UI, tests), never a horizontal slice of one layer
- A finished phase is demoable or verifiable on its own
- Many thin slices beat a few thick ones
- Include durable decisions (route paths, schema shapes, model names). Leave out file names, function names, and anything else likely to be renamed by the time that phase is reached

Create `plans/` if it does not exist. Write `plans/<slug>.md` using the plan template in [TEMPLATES.md](TEMPLATES.md). Both files share the same slug.

### 6. Report and stop

Print both file paths, the phase titles as a one-line-each list, and any assumption made in place of a question. Then stop. Do not begin implementing, and do not offer to.
