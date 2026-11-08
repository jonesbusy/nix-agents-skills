# Nix Agent Skills

A reusable Home Manager module that installs selected agent skills under `~/.agents/skills`. It manages skills only; it does not install or configure Pi, Hermes Agent, OpenCode, or other agent applications.

## Use in a Home Manager flake

Add this entry to your flake's existing `inputs` set:

```nix
nix-agents-skills = {
  url = "github:jonesbusy/nix-agents-skills";
  inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.follows = "home-manager";
};
```

Import its module in your Home Manager configuration:

```nix
modules = [
  inputs.nix-agents-skills.homeManagerModules.default
  # Your other Home Manager modules
];
```

The module defines the skill sources and selection in one place. Home Manager links the selected skills into `~/.agents/skills`, independently of any agent application.

## Validate

With Nix flakes and `prek` installed, run:

```sh
nix fmt -- --ci
nix eval --impure --file tests/skills.nix
nix flake check --no-build
prek run --all-files
```
