let
  flake = builtins.getFlake (toString ../.);
  module = flake.homeManagerModules.default { };
  config = module.programs.agent-skills;
  homeManagerCheck = flake.checks.x86_64-linux.home-manager-module;
  skills = config.skills.explicit;
  namesFrom =
    source:
    builtins.sort builtins.lessThan (
      builtins.filter (name: skills.${name}.from == source) (builtins.attrNames skills)
    );
in
assert
  namesFrom "awesome-copilot" == [
    "codeql"
    "create-readme"
    "github-actions-efficiency"
    "github-actions-hardening"
    "github-actions-runtime-upgrade-conventions"
    "github-issues"
    "java-development"
    "lean-comments"
    "quarkus-application-development"
    "quarkus-native-and-container"
  ];
assert
  namesFrom "softaworks-agent-toolkit" == [
    "agent-md-refactor"
    "excalidraw"
    "humanizer"
    "professional-communication"
    "writing-clearly-and-concisely"
  ];
assert builtins.all (
  name:
  builtins.pathExists (config.sources.softaworks-agent-toolkit.path + "/skills/${name}/SKILL.md")
) (namesFrom "softaworks-agent-toolkit");
assert config.skills.enableAll == [ "jbang-agent-skills" ];
assert builtins.pathExists (config.sources.jbang-agent-skills.path + "/jbang/SKILL.md");
assert builtins.pathExists (config.sources.jbang-agent-skills.path + "/jbang-scripting/SKILL.md");
assert skills."gh-fix-ci".from == "openai";
assert skills."quarkus-update".from == "quarkus";
assert skills."security-audit".from == "cloudflare-security-audit-skill";
assert skills.caveman.from == "caveman";
assert skills.caveman.path == "caveman";
assert builtins.pathExists (config.sources.caveman.path + "/skills/caveman/SKILL.md");
assert builtins.all
  (
    name:
    skills.${name}.from == "caveman"
    && skills.${name}.path == name
    && builtins.pathExists (config.sources.caveman.path + "/skills/${name}/SKILL.md")
  )
  [
    "investigate-first"
    "surgical-patch"
    "safe-refactor"
    "verify-and-stop"
  ];
assert builtins.pathExists (
  config.sources.cloudflare-security-audit-skill.path + "/skills/security-audit/SKILL.md"
);
assert config.targets.agents.enable;
assert config.targets.agents.structure == "symlink-tree";
assert builtins.length module.imports == 1;
assert homeManagerCheck.drvPath != "";
true
