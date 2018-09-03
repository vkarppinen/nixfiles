{ pkgs, prefix, ... }:

{
  home.packages = with pkgs; [
    powerline-fonts # for spaceship prompt
  ];

  programs.git = {
    enable = true;
    userName = "vkarppinen";
    userEmail = "karppinenvaltteri@gmail.com";
  };

  programs.zsh.enable = true;
  programs.zsh.history.share = false;
  programs.zsh.shellAliases = {
    nix-shell = "nix-shell --command \"export __ETC_ZSHENV_SOURCED=1; export SPACESHIP_CHAR_PREFIX=\\\"(nix) \\\"; exec $(which zsh); return\"";
  };
  programs.zsh.initExtra = ''
    EDITOR="vim";
    NIX_REMOTE="daemon";
    GS_OPTIONS="-sPAPERSIZE=a4";
    SSL_CERT_FILE="/etc/ssl/certs/ca-bundle.crt";
    SPACESHIP_EXIT_CODE_SHOW=true;
    SPACESHIP_DIR_TRUNC=0;
    SPACESHIP_DIR_TRUNC_REPO=false;
    SPACESHIP_PROMPT_ORDER=(time user dir host git exec_time line_sep battery jobs exit_code char);
    bindkey -e
  '';
  programs.zsh.plugins = [
    {
      name = "spaceship";
      file = "spaceship.zsh";
      src = pkgs.fetchgit {
        url = "https://github.com/denysdovhan/spaceship-prompt";
        rev = "v3.3.0";
        sha256 = "1fp0qs50jhqffkgk9b65fclz7vcxcm97s8i1wxry0z9vky8zbna5";
      };
    }
  ];

}
