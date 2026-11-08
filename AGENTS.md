# Repository guidance

This flake exports a Home Manager module for agent skills only. Keep skill sources, selections, and the `~/.agents/skills` target in `home/skills.nix`. Do not add agent application packages, per-agent configuration, user-specific paths, or system configuration here.

## Validate

Stage new and modified files before evaluating the flake; Nix reads Git checkout sources from tracked files. Run:

```sh
nix eval --impure --file tests/skills.nix
nix flake check --no-build
prek run --all-files
```

Do not activate Home Manager or change installed tools from this repository unless explicitly requested. Do not push without explicit user approval. Never add credentials or private agent state.

Keep GitHub Actions permissions read-only unless a workflow feature requires more, avoid privileged pull-request triggers, and pin actions to full commit SHAs.
