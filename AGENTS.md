# Repository guidance

This flake exports a Home Manager module for agent skills only. Keep skill sources, selections, and the `~/.agents/skills` target in `home/skills.nix`. Do not add agent application packages, per-agent configuration, user-specific paths, or system configuration here.

Do not invoke or follow Superpowers workflows or skills for work in this repository. Follow this file and the user's instructions instead.

## Add skills

1. Add each new skill repository as an input in `flake.nix`, pass it through `outputs` to `home/skills.nix`, and register it under `programs.agent-skills.sources` with its repository path and, if needed, a `subdir`.
2. Select individual skills in `programs.agent-skills.skills.explicit` by source name and skill path. Use `skills.enableAll` only when every skill from that source should be installed. Keep skill names unique.
3. Update `tests/skills.nix` assertions when adding or changing selections, paths, or sources. Confirm each selected path contains a `SKILL.md`.

## Validate

Stage new and modified files before evaluating the flake; Nix reads Git checkout sources from tracked files. Run:

```sh
nix eval --impure --file tests/skills.nix
nix flake check --no-build
prek run --all-files
```

Do not activate Home Manager or change installed tools from this repository unless explicitly requested. Do not push without explicit user approval. Never add credentials or private agent state.

Keep GitHub Actions permissions read-only unless a workflow feature requires more, avoid privileged pull-request triggers, and pin actions to full commit SHAs.
