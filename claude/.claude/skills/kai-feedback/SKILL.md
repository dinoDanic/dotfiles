---
name: kai-feedback
description: Improve kai-cli instruction files based on bad code generation output. Use when user wants to fix or improve kai instructions after Claude generated wrong or suboptimal code, or mentions "kai-feedback".
---

# kai-feedback

Analyze bad code generation and update kai instruction files so the issue doesn't recur.

**Instructions path**: `~/kodius/kai/instructions/`
**Manifest path**: `~/kodius/kai/manifest.json`

## Step 1 — Gather context

Collect evidence from the current project:

- Review the conversation history to find the user's original prompt/command that triggered the code generation — this shows what was asked for and helps understand the gap between intent and output
- Run `git diff` and `git diff --cached` to see recently generated code
- Run `git log --oneline -5` for recent commit context
- Read the user's description of what is wrong

Identify: what was asked, what code was generated, why it's wrong, and what the correct pattern should be.

## Step 2 — Find the right instruction file

Read the manifest at `~/kodius/kai/manifest.json`. Match the problem domain against each instruction's `tags`, `trigger`, and `description`.

The manifest has multiple presets (e.g. `nextjs`, `react-native`). Each preset references a list of instruction IDs. Instructions can be shared across presets (e.g. `react`, `types`) or preset-specific (e.g. `nextjs`, `react-native`).

**Decision rule**:
- Problem fits an existing instruction's domain → update that file
- Problem spans multiple instructions → update the most specific one
- No existing instruction covers this domain → create a new file
- If the rule is platform-specific, place it in the platform-specific instruction (e.g. `react-native-common.md`, `nextjs/index.md`). If it applies to all platforms, place it in a shared instruction (e.g. `react`, `types`).

Tell the user which file you will update (or that you'll create a new one) and why.

## Step 3 — Read the current instruction file

Instructions live in `~/kodius/kai/instructions/{id}/` directories. Each has an `index.md` entry point and optional sub-files. Read the target file and understand its existing rules and structure so the new rule fits naturally.

## Step 4 — Write the rule

Add a new `## Section` to the instruction file (or edit an existing section if it partially covers the issue). Default format:

```
## Rule name — short imperative

One-sentence explanation of why this rule exists.
```

**Default to no code example.** Prose is cheaper than code and most rules are self-explanatory. Only add a code example when the correct pattern is genuinely hard to guess from the description — non-obvious syntax, a specific API shape, subtle ordering, or a discriminated-union/generic structure that's easier to show than describe.

**When you do add an example, show the correct pattern only.** Do NOT include an `// ✗ avoid` / `// ✓ correct` pair by default. The prose already says what to avoid; duplicating it as code wastes tokens. Only include an `avoid` snippet when the wrong pattern is visually very close to the correct one and readers would misread the rule otherwise.

Guidelines:
- Place the new section in a logical position relative to existing rules
- Match the tone and style of the rest of the file
- Keep rules atomic — one concept per section
- No frontmatter — instruction files are plain Markdown

## Step 5 — Update manifest (new files only)

If you created a new instruction file, add an entry to the `instructions` array in manifest.json:

```json
{
  "id": "kebab-case-id",
  "name": "Human Readable Name",
  "description": "Brief description of what patterns this covers",
  "category": "frontend",
  "tags": ["relevant", "tags"],
  "trigger": "When <natural language condition>",
  "files": ["index.md"]
}
```

Also add the new id to the relevant presets in the `presets` array. Ask the user which preset(s) the instruction belongs to if it's not obvious from the domain.

## Step 6 — Sync to example projects

After updating an instruction file, check if any example projects inside `~/kodius/kai/examples/` have the same file in their `.kai/` folder. If the file exists there, copy the updated version over so the example stays in sync without needing `kai update`.

## Step 7 — Apply the fix in the current project

The feedback was triggered by real bad code in the current project. After updating the instruction file, apply the new rule to the offending code so the project is left in a correct state. Use the file(s) identified in Step 1 as the starting point, and check for other instances of the same pattern nearby.

## Step 8 — Summarize

Tell the user:
1. Which file was updated or created
2. What rule was added (the `##` heading)
3. The bad pattern it prevents
4. What was fixed in the current project
5. Remind them to run `kai update` in projects using this instruction to pull the change
