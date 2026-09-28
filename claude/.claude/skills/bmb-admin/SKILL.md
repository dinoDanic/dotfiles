---
name: bmb-admin
description: Connects to and works in the BMB Invest website admin (bmb.hr, old Joomla 3.10 + JoomShopping 4.18 webshop) through a Chromium browser the user logs into. Use for any task on bmb.hr — products, prices, categories, characteristics, template/CSS, config, content, modules — or when the user mentions bmb, BMB Invest, bmb.hr, bmb administrator, jshopping, JoomShopping, sidrena cijena. Triggers: "bmb", "spoji se na bmb", "otvori bmb admin", "na bmb-u", "promijeni na siteu bmb".
---

# BMB Invest admin (bmb.hr)

Old client site: **Joomla 3.10.12** + **JoomShopping 4.18.4** (webshop for roštilji, pečenjare, krušne peći, obloge...). Tasks vary — not always JoomShopping. There is **no DB / FTP / SSH access**; everything goes through the admin UI (and the Joomla template editor for files).

- Admin: https://bmb.hr/administrator/index.php
- Site: https://bmb.hr

## 1. Connect (always do this first, don't ask)

The chrome-devtools MCP can't start here (it looks for Google Chrome at `/opt/google/chrome/chrome`, only `chromium`/`brave` are installed). Use the CLI via npx with Chromium instead:

```bash
C="npx -y -p chrome-devtools-mcp@latest chrome-devtools"
$C start --headless=false --executablePath=/usr/bin/chromium
$C new_page "https://bmb.hr/administrator/index.php"
```

Then tell the user the window is open and **wait for them to log in** — never ask for or type credentials. After login, `$C list_pages` to get the page id (usually 2).

Working pattern:
- `$C navigate_page <id> --url "..."` then `$C evaluate_script "() => ..." --pageId <id>` to read/fill forms — faster than snapshots on these big admin pages.
- Save forms with `Joomla.submitbutton('save')` (or `'apply'`, `'template.save'` in the template editor).
- Multi-selects are Chosen widgets: set `option.selected`, then `jQuery(s).trigger('liszt:updated')`.
- Verify after every save (reload and re-read the value, check the front end).
- To show the user a spot in admin: navigate, click the right tab, `scrollIntoView`, add a red outline, `$C select_page <id> --bringToFront true`.

## 2. Site structure

- Front-end template: **bmb** (style id 19, template id 10050). Its CSS files are in `templates/bmb/css/`; custom overrides go at the end of **`over2.css`**. Edit via Sustav → Templates → bmb (URL `index.php?option=com_templates&view=template&id=10050&file=<base64 path>`, CodeMirror: `document.querySelector('.CodeMirror').CodeMirror`, then `cm.save()` before submitting).
- Don't edit `components/com_jshopping/css/*` — a JoomShopping update overwrites it.
- **Caching**: nginx caches static files (`x-nginx-upstream-cache-status: STALE`) and sends CSS with `max-age=2592000` (30 days). A CSS change can be saved but invisible. Check with `curl -s "https://bmb.hr/templates/bmb/css/over2.css?v=$(date +%s)"`, preview by injecting a cache-busted `<link>`, and tell the user. The HTML is not stale-cached.

## 3. JoomShopping map

Admin URLs are `index.php?option=com_jshopping&controller=<x>`:

| What | controller / notes |
|---|---|
| Products list | `products&category_id=0` (search: `&text_search=...`) |
| Edit product | `products&task=edit&product_id=<id>` — tabs incl. **Characteristics** |
| Categories | `categories` |
| Characteristics (extra fields) | `productfields` (edit: `&task=edit&id=<id>`), values for list types: `productfieldvalues&field_id=<id>` |
| Config (product list / product page) | `config&task=catprod` |
| Labels, manufacturers, taxes, currencies, orders... | `productlabels`, `manufacturers`, `taxes`, `currencies`, `orders` |
| Import & Export (CSV) | `importexport` — the way to bulk-edit, since there's no DB |

Useful facts:
- Characteristics are stored as `extra_field_<id>` columns on the product; in the product form the input is `name="extra_field_<id>"`. Type radio values: `0` List, `-1` Multiple List, `1` Text.
- Config `catprod` selects: `product_list_display_extra_fields[]` (shown on list cards), `product_hide_extra_fields[]` (hidden on product page), `filter_display_extra_fields[]`, `cart_display_extra_fields[]`.
- Built-in features exist for most things (old price, labels, characteristics, "bez PDV-a" price) — check config before suggesting paid addons. The client once bought a module for the net price; avoid that if core can do it.
- List card template markup: `.oiproduct` holds price/extra info; `.oiproduct .extra_fields` is hidden by JoomShopping's `responsive.css` and re-enabled in `over2.css`.

## 4. Current customizations (keep in sync when you change things)

**Sidrena cijena (anchor price) on list cards** — added 2026-09-24:
- Characteristic **ID 228** "Sidrena cijena (10.09.2026.)", type Text, all categories. Client enters **only the number** (e.g. `159,54`) in the product's Characteristics tab. To change the date, rename the characteristic.
- `product_list_display_extra_fields` = only 228. Previously selected (hidden by CSS anyway), for revert: `5,13,22,25,27,33,39,43,52,79,200,99,100,101,106,130,224,182,192,227`.
- `product_hide_extra_fields` includes 228 (the product page has the anchor price in the description, and the € suffix only applies on cards).
- End of `over2.css`:
  ```css
  .oiproduct .extra_fields { display: block; font-size: 13px; color: #555; margin-top: 4px; }
  .oiproduct .extra_fields .data::after { content: " €"; }
  ```
  So any other characteristic added to the list later would also get " €" — adjust the CSS if that happens.
- Example product: Mini kamin 2 (product_id 412).
