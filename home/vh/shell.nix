{ ... }:

{
  home.shellAliases.nhoss = "nh os switch";

  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    historySize = 100000;
    historyFileSize = 100000;
    shellOptions = [
      "histappend" # don't clobber history between concurrent shells
      "checkwinsize"
      "globstar" # ** recursive glob
    ];
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      # Show how long slow commands took.
      cmd_duration.min_time = 2000;
    };
  };

  # Per-project toolchains loaded on `cd` via .envrc.
  # nix-direnv adds caching and keeps dev shells safe from GC.
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # Fuzzy-matches previously visited directories by frecency: `z foo` cd's
  # into the best match even if "foo" is a partial/fuzzy substring.
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
}
