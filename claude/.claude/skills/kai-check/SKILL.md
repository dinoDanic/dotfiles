---
name: kai-check
description: Check if a file follows the rules defined in the project's CLAUDE.md. Use when user wants to validate, audit, or check a file against kai rules, or passes a file and asks if it follows the rules.
---

# kai-check

Validate a file against the rules in the project's `CLAUDE.md`.

## Step 1 — Read the target file

The user provides a file path. Read it in full.

## Step 2 — Read the project rules

Read `CLAUDE.md` in the project root. It contains rules and references (via `@.kai/*.md` imports) that define the coding conventions for this project. Follow all `@` imports to read the referenced instruction files as well.

## Step 3 — Check the file against each rule

For each rule found in `CLAUDE.md` and its referenced files:

1. Determine if the rule is relevant to the target file
2. If relevant, check whether the file follows or violates the rule
3. Record violations with the rule name and what specifically is wrong

Skip rules that don't apply to the file.

## Step 4 — Report results

Present a clear report:

```
## kai-check: {filename}

### Violations

- **Rule name**: What is wrong and how to fix it
  ```tsx
  // current (violation)
  <the violating code snippet>

  // expected
  <what it should look like per the rule>
  ```

### Passed

- **Rule name**: Brief confirmation
```

If there are no violations:

```
## kai-check: {filename}

All applicable rules pass. No violations found.
```

## Step 5 — Offer to fix

If there are violations, ask the user: "Want me to fix these violations?"
