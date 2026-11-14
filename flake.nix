{
  description = "Reusable Home Manager module for agent skills";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agent-skills-nix = {
      url = "github:Kyure-A/agent-skills-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aws-agent-toolkit = {
      url = "github:aws/agent-toolkit-for-aws";
      flake = false;
    };

    openai-skills = {
      url = "github:openai/skills";
      flake = false;
    };

    quarkus-skills = {
      url = "github:quarkusio/skills";
      flake = false;
    };

    awesome-copilot = {
      url = "github:github/awesome-copilot";
      flake = false;
    };

    jbang-agent-skills = {
      url = "github:jbangdev/agent-skills";
      flake = false;
    };

    softaworks-agent-toolkit = {
      url = "github:softaworks/agent-toolkit";
      flake = false;
    };

    cloudflare-security-audit-skill = {
      url = "github:cloudflare/security-audit-skill";
      flake = false;
    };

    caveman = {
      url = "github:JuliusBrussee/caveman";
      flake = false;
    };
  };

  outputs =
    {
      agent-skills-nix,
      aws-agent-toolkit,
      home-manager,
      nixpkgs,
      openai-skills,
      quarkus-skills,
      awesome-copilot,
      jbang-agent-skills,
      softaworks-agent-toolkit,
      cloudflare-security-audit-skill,
      caveman,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      skillsModule = import ./home/skills.nix {
        inherit
          agent-skills-nix
          aws-agent-toolkit
          nixpkgs
          openai-skills
          quarkus-skills
          awesome-copilot
          jbang-agent-skills
          softaworks-agent-toolkit
          cloudflare-security-audit-skill
          caveman
          ;
      };
      homeManagerConfig = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          skillsModule
          {
            home.username = "test";
            home.homeDirectory = "/tmp/agent-skills-test";
            home.stateVersion = "25.05";
          }
        ];
      };
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;

      homeManagerModules.default = skillsModule;
      checks.${system}.home-manager-module =
        assert homeManagerConfig.config.programs.agent-skills.enable;
        assert homeManagerConfig.config.programs.agent-skills.targets.agents.enable;
        assert homeManagerConfig.config.programs.agent-skills.targets.agents.dest == "$HOME/.agents/skills";
        assert homeManagerConfig.config.programs.agent-skills.targets.agents.structure == "symlink-tree";
        pkgs.runCommand "agent-skills-home-manager-module" { } "touch $out";
    };
}
