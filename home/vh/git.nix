{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "vohaha";
      user.email = "dev@volodymyrkondratenko.com";
      init.defaultBranch = "main";
    };
    ignores = [ "**/.claude/settings.local.json" ];
  };
}
