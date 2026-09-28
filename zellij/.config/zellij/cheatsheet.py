#!/usr/bin/env python3
"""Render a boxed keybind cheat sheet from ~/.config/zellij/config.kdl."""
import math
import os
import re
import shutil
import sys

CONFIG = os.path.expanduser("~/.config/zellij/config.kdl")

C = {
    "reset": "\033[0m", "dim": "\033[2m", "bold": "\033[1m",
    "box": "\033[38;5;60m", "title": "\033[1;38;5;213m",
    "key": "\033[1;38;5;117m", "act": "\033[38;5;252m",
    "accent": "\033[38;5;108m",
}
if not sys.stdout.isatty() or os.environ.get("NO_COLOR"):
    C = {k: "" for k in C}

ANSI = re.compile(r"\033\[[0-9;]*m")
vlen = lambda s: len(ANSI.sub("", s))

# ---------------------------------------------------------------- parsing

def parse(text):
    """Return [(scope_label, [(key, actions)])] in file order."""
    lines = text.splitlines()
    i = 0
    while i < len(lines) and not re.match(r"\s*keybinds\b", lines[i]):
        i += 1
    i += 1
    depth, scopes, current, order = 1, {}, None, []
    while i < len(lines) and depth > 0:
        line = lines[i].strip()
        i += 1
        if not line or line.startswith("//"):
            continue

        m = re.match(r'^bind\s+((?:"[^"]+"\s*)+)\{(.*)$', line)
        if m and current:
            keys = re.findall(r'"([^"]+)"', m.group(1))
            body = m.group(2)
            if "}" not in body:                       # multi-line bind body
                buf, d = [body], 1 + body.count("{") - body.count("}")
                while i < len(lines) and d > 0:
                    nxt = lines[i]
                    i += 1
                    d += nxt.count("{") - nxt.count("}")
                    buf.append(nxt.strip())
                body = " ".join(buf)
            actions = body.rsplit("}", 1)[0] if "}" in body else body
            scopes[current].append((keys, actions.strip()))
            continue

        if line.endswith("{"):
            depth += 1
            head = line[:-1].strip()
            names = re.findall(r'"([^"]+)"', head)
            if head.startswith("shared_among"):
                label = ("ALT KEYS (work in locked too)"
                         if set(names) == {"normal", "locked"}
                         else "IN: " + "/".join(names))
            elif head.startswith("shared_except"):
                shown = [n for n in names if n not in
                         ("entersearch", "search", "renametab", "renamepane")]
                label = ("ANY MODE EXCEPT " + "/".join(shown or ["locked"])
                         + ("" if len(shown) == len(names) else " (+ rename/search)"))
            else:
                label = (head.split()[0] if head else "?").upper()
            scopes.setdefault(label, []) == [] and order.append(label)
            current = label
            continue

        if line.startswith("}"):
            depth -= line.count("}")
            if depth <= 1:
                current = None
    return [(s, scopes[s]) for s in order if scopes[s]]

# ---------------------------------------------------------------- prettify

DIR = {"left": "←", "down": "↓", "up": "↑", "right": "→"}
CAP = {"tab": "⇥", "enter": "⏎", "esc": "esc", "space": "␣",
       "PageUp": "PgUp", "PageDown": "PgDn"}

RULES = [
    (r'^MoveFocusOrTab "(\w+)"$',            lambda m: f"focus/tab {DIR[m[1]]}"),
    (r'^MoveFocus "(\w+)"$',                 lambda m: f"focus {DIR[m[1]]}"),
    (r'^MovePane "(\w+)"$',                  lambda m: f"move pane {DIR[m[1]]}"),
    (r'^MoveTab "(\w+)"$',                   lambda m: f"move tab {DIR[m[1]]}"),
    (r'^NewPane "(\w+)"$',                   lambda m: f"new pane {DIR.get(m[1], m[1])}"),
    (r'^Resize "Increase (\w+)"$',           lambda m: f"grow {DIR[m[1]]}"),
    (r'^Resize "Decrease (\w+)"$',           lambda m: f"shrink {DIR[m[1]]}"),
    (r'^Resize "Increase"$',                 lambda m: "grow"),
    (r'^Resize "Decrease"$',                 lambda m: "shrink"),
    (r'^GoToTab (\d+)$',                     lambda m: f"go to tab {m[1]}"),
    (r'^Search "down"$',                     lambda m: "next match"),
    (r'^Search "up"$',                       lambda m: "prev match"),
    (r'^SearchToggleOption "(\w+)"$',        lambda m: f"toggle {m[1].lower()}"),
    (r'^Run .*?name "([^"]+)".*$',           lambda m: f"run: {m[1]}"),
    (r'^Run "([^"]+)".*$',                   lambda m: f"run: {m[1]}"),
    (r'^LaunchOrFocusPlugin "([\w:-]+)".*$', lambda m: m[1].split(":")[-1].replace("-", " ")),
    (r'^SwitchToMode "(\w+)"$',              lambda m: f"→ {m[1]} mode"),
    (r'^(\w+)Input 0$',                      lambda m: None),        # drop noise
]
WORDS = {
    "NewPane": "new pane", "NewTab": "new tab", "CloseFocus": "close pane",
    "CloseTab": "close tab", "Detach": "detach", "Quit": "quit zellij",
    "SwitchFocus": "next pane", "ToggleTab": "last tab",
    "GoToNextTab": "next tab", "GoToPreviousTab": "prev tab",
    "ToggleFocusFullscreen": "fullscreen", "ToggleFloatingPanes": "floating panes",
    "TogglePaneEmbedOrFloating": "float ⇄ embed", "TogglePanePinned": "pin pane",
    "TogglePaneFrames": "pane frames", "ToggleActiveSyncTab": "sync tab input",
    "TogglePaneInGroup": "add to group", "ToggleGroupMarking": "group marking",
    "MovePane": "move pane", "MovePaneBackwards": "move pane back",
    "BreakPane": "pane → new tab", "BreakPaneLeft": "pane → tab ←",
    "BreakPaneRight": "pane → tab →", "EditScrollback": "edit scrollback",
    "ScrollUp": "scroll ↑", "ScrollDown": "scroll ↓",
    "PageScrollUp": "page ↑", "PageScrollDown": "page ↓",
    "HalfPageScrollUp": "half page ↑", "HalfPageScrollDown": "half page ↓",
    "ScrollToBottom": "jump to bottom",
    "UndoRenameTab": "cancel rename", "UndoRenamePane": "cancel rename",
    "PreviousSwapLayout": "prev layout", "NextSwapLayout": "next layout",
}

def describe(actions):
    parts = [p.strip() for p in actions.split(";") if p.strip()]
    out = []
    for p in parts:
        p = re.sub(r"\s+", " ", p)
        hit = None
        for pat, fn in RULES:
            m = re.match(pat, p)
            if m:
                hit = fn(m)
                break
        if hit is None and not any(re.match(pat, p) for pat, _ in RULES):
            hit = WORDS.get(p.split()[0], p)
        if hit:
            out.append(hit)
    if len(out) > 1 and out[-1] == "→ locked mode":
        out = out[:-1]                       # returning to locked is implicit
    return " + ".join(out) or "—"

def keycap(keys):
    caps = []
    for k in keys:
        k = k.replace("Ctrl ", "^").replace("Alt ", "M-").replace("Shift ", "S-")
        caps.append(CAP.get(k, DIR.get(k, k)))
    return "/".join(caps)

def collapse(binds):
    """Merge keys that trigger the same action, keep file order."""
    seen, rows = {}, []
    for keys, act in binds:
        d = describe(act)
        if d in seen:
            rows[seen[d]][0].extend(keys)
        else:
            seen[d] = len(rows)
            rows.append([list(keys), d])
    return [(keycap(k), d) for k, d in rows]

# ---------------------------------------------------------------- render

def section(title, rows, width):
    kw = min(max(vlen(keycap([r[0]])) for r in rows), 14)
    kw = min(max(len(r[0]) for r in rows), 16)
    longest = max(len(r[1]) for r in rows) + kw + 4
    ncols = 2 if (width >= 84 and len(rows) > 4 and longest * 2 < width) else 1
    inner = width - 4
    colw = (inner - (ncols - 1) * 3) // ncols

    body_lines = []
    per = math.ceil(len(rows) / ncols)
    cols = [rows[i * per:(i + 1) * per] for i in range(ncols)]
    for r in range(per):
        cells = []
        for col in cols:
            if r < len(col):
                k, d = col[r]
                room = colw - kw - 2
                if len(d) > room > 4:
                    d = d[:room - 1] + "…"
                cell = f"{C['key']}{k:<{kw}}{C['reset']}  {C['act']}{d}{C['reset']}"
                cells.append(cell + " " * max(0, colw - vlen(cell)))
            else:
                cells.append(" " * colw)
        body_lines.append(f" {C['box']}│{C['reset']} ".join(cells))

    span = width - 4                                 # every box gets the same width
    if vlen(title) > span - 4:
        title = title[:span - 5] + "…"
    out = [f"{C['box']}┌─{C['reset']} {C['title']}{title}{C['reset']} "
           f"{C['box']}{'─' * max(1, span - vlen(title) - 1)}┐{C['reset']}"]
    for b in body_lines:
        pad = " " * (span - vlen(b))
        out.append(f"{C['box']}│{C['reset']} {b}{pad} {C['box']}│{C['reset']}")
    out.append(f"{C['box']}└{'─' * (span + 2)}┘{C['reset']}")
    return out

def main():
    width = min(shutil.get_terminal_size((100, 40)).columns, 130)
    scopes = parse(open(CONFIG).read())

    print()
    print(f"  {C['title']}ZELLIJ KEYBINDS{C['reset']}   "
          f"{C['dim']}{CONFIG.replace(os.path.expanduser('~'), '~')}{C['reset']}")
    print(f"  {C['accent']}^g{C['reset']} {C['dim']}locked ⇄ normal{C['reset']}   "
          f"{C['accent']}?{C['reset']} {C['dim']}this sheet{C['reset']}   "
          f"{C['accent']}esc{C['reset']} {C['dim']}back to locked{C['reset']}   "
          f"{C['accent']}q{C['reset']} {C['dim']}close{C['reset']}\n")

    enter, glob, rename, sections = [], [], [], []
    for label, binds in scopes:
        rows = collapse(binds)
        shared = label.startswith(("ANY MODE EXCEPT", "IN:", "ALT KEYS"))
        if label == "LOCKED":
            continue                                  # covered by the header line
        bare = set(label.upper().replace("IN: ", "").split("/"))
        if bare <= {"RENAMETAB", "RENAMEPANE"}:
            rename.extend(rows)
        elif shared and not label.startswith("ALT KEYS"):
            keep = []
            for k, d in rows:
                if d.startswith("→ ") and d.endswith(" mode") and "locked" not in d:
                    enter.append((k, d[2:-5]))
                elif label.startswith("ANY MODE EXCEPT"):
                    glob.append((k, d))
                else:
                    keep.append((k, d))
            if keep:
                sections.append((label, keep))
        else:
            sections.append((label, rows))

    ordered = []
    if enter:
        ordered.append(("ENTER MODE  (press ^g first if locked)", enter))
    if glob:
        ordered.append(("GLOBAL  (any mode except locked)", glob))
    ordered += sections
    if rename:
        ordered.append(("RENAMING  (tab / pane)", rename))

    for title, rows in ordered:
        for line in section(title, rows, width):
            print(line)
        print()

main()
