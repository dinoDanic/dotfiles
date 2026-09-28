# Templates

Two files, same slug. `prd/<slug>.md` explains what and why, `plans/<slug>.md` explains the order of execution. Keep them non-overlapping: user stories live only in the PRD, acceptance criteria live only in the plan.

## PRD template

<prd-template>

## Problem Statement

The problem the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User Stories

A LONG, numbered list of user stories, each in the format:

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

This list should be extensive and cover every aspect of the feature.

## Implementation Decisions

The decisions that came out of the interview and the codebase exploration. This can include:

- The modules that will be built or modified
- The interfaces of those modules that change
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Mark anything assumed rather than answered, so it is obvious what was never confirmed.

Do NOT include specific file paths or code snippets. They go stale fast.

## Out of Scope

What this PRD does not cover.

## Further Notes

Anything else worth recording.

</prd-template>

## Plan template

<plan-template>
# Plan: <Feature Name>

> Source PRD: prd/<slug>.md

## Architectural decisions

Durable decisions that apply across all phases:

- **Routes**: ...
- **Schema**: ...
- **Key models**: ...
- (add or remove sections as appropriate)

---

## Phase 1: <Title>

**User stories**: <numbers from the PRD>

### What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not a layer-by-layer implementation.

### Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

---

## Phase 2: <Title>

**User stories**: <numbers from the PRD>

### What to build

...

### Acceptance criteria

- [ ] ...

<!-- Repeat for each phase. Every user story in the PRD must appear in some phase. -->
</plan-template>
