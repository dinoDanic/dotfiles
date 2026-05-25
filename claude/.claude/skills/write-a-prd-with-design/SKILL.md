---
name: write-a-prd-with-design
description: Create a PRD when starting from a folder of Claude-generated UI design files (HTML/CSS, React/JSX, PNG/JPG). Same outcome as /write-a-prd, but enriched by reading the designs as UI reference and copying them alongside the PRD. Use when the user passes a path to a design folder and wants to turn those designs into a PRD, or mentions "PRD with design", "designs to PRD", or "/write-a-prd-with-design".
---

# Write a PRD with Design

The user has a folder of Claude-generated UI design files and wants to turn it into a PRD.

**Designs are UI reference only — NOT the source of truth for logic.** Logic decisions come from the existing code and from interviewing the user. Never copy behavior out of a design file without confirming it.

## Inputs

The user passes a path to a folder (already extracted if it was a zip). If the path is a `.zip` file or doesn't exist, stop and ask the user to extract it and pass a folder path.

## Workflow

1. **Inventory the design folder.**
   - List every file. Identify types: HTML/CSS, JSX/TSX, images (PNG/JPG/SVG), other.
   - Read each text-based file with the Read tool. View each image with the Read tool (it accepts images).
   - Build a mental map: what screens/flows exist, key UI elements, interactions the design implies.

2. **Ground logic in code, not in designs.**
   - Explore the repo to see what already exists in the areas the designs touch.
   - Note gaps: things the design shows that don't exist yet in code, and things the code does that the designs don't reflect. Both will become interview questions.

3. **Run the `/write-a-prd` interview, enriched with design context.**
   - Follow the `/write-a-prd` skill's interview process to clarify every decision.
   - Use the designs to ask sharper questions: "The design shows X — is this load-bearing logic or just a visual placeholder?", "The design implies Y interaction — does it call an existing endpoint or a new one?"
   - Use the `AskUserQuestion` tool for every interview question, with 2–4 labeled options (first marked "(Recommended)"). Group up to 4 related questions per call.

4. **Pick a `<prd-name>` slug** (kebab-case, derived from the feature). This same slug is used for both the PRD file and the designs folder.

5. **Copy the designs alongside the PRD.**
   - Create `prd/<prd-name>-designs/` and copy every file from the source folder into it (`cp -r <source>/. prd/<prd-name>-designs/`).
   - These copies are what the PRD will reference, so the PRD stays self-contained even if the original source folder moves.

6. **Write the PRD to `prd/<prd-name>.md`** using the `/write-a-prd` template (Problem Statement, Solution, User Stories, Implementation Decisions, Out of Scope, Further Notes), plus one extra section at the end:

   ```
   ## Design Reference

   UI reference only — not the source of truth for logic. See `prd/<prd-name>-designs/`.

   - `<file>` — one-line note on what it shows
   - ...
   ```

## Rules

- If a design implies a behavior (endpoint, validation, state transition), confirm it with the user or verify it in code before writing it into Implementation Decisions.
- The PRD must stand alone — a future reader should understand the feature from the PRD text, with the designs as supporting visual reference.
- Do not include file paths or code snippets inside Implementation Decisions (same constraint as `/write-a-prd`).
