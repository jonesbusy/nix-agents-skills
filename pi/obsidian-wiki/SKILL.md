---
name: obsidian-wiki
description: Maintain the user's LLM Wiki in Obsidian using the vault's existing schema and Hermes-compatible conventions. Use when researching, creating, or updating synthesized wiki pages in the Obsidian vault; do not use for unrelated ordinary notes unless asked to integrate them.
---

# Obsidian LLM Wiki

Maintain the LLM Wiki using the Obsidian tools and the vault's own `SCHEMA.md` as the source of truth. This skill is for Pi; keep it installed under Pi's skill directory, not the shared `~/.agents/skills` directory used by Hermes.

## Before changing the wiki

1. Resolve the intended vault with `obsidian_list_vaults` if the vault is not known. Valentin's wiki is the `personal` vault.
2. Read `SCHEMA.md`, `index.md`, and `log.md` before a wiki change. Read `home.md` when changing navigation or when it is relevant.
3. Search/list existing notes and read likely matches before creating a page. Update an existing page rather than creating a duplicate.
4. Keep ordinary vault notes outside wiki-managed folders out of scope unless explicitly asked to integrate them.

## Wiki page conventions

- Follow `SCHEMA.md` for folder placement, lowercase kebab-case filenames, frontmatter, types, tags, provenance, linking, page thresholds, and conflict handling.
- Preserve source captures under `raw/` as immutable. Put synthesis, corrections, and analysis in wiki pages. Cite supporting sources near claims, and do not invent provenance or dates.
- Preserve existing content and metadata when updating. Never silently overwrite conflicting claims; retain both with dates and sources and mark unresolved conflicts for review.
- Add meaningful `[[wikilinks]]`; do not add links just to satisfy a quota.
- Keep sensitive governance cases and correspondence inside this private vault.

## Keep navigation and history consistent

Whenever creating, moving, or materially updating a wiki page:

1. Update `index.md` so the page is discoverable in the appropriate section. Keep its page count and last-updated date accurate when those values are present.
2. Append a dated entry to `log.md` using its existing format. The log is append-only; do not rewrite history.
3. Update `home.md` only when the change affects the vault's intended entry-point navigation.

Use the Obsidian tools to read, search, list, create, and append notes. Before replacing a note, read it and preserve unrelated content. Do not edit raw captures. If a necessary schema or navigation decision is unclear, ask rather than inventing a convention.
