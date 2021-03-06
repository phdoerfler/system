{ config, pkgs, ... }:
{
  imports = [
    ./keylayout.nix
  ];

  environment.variables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
  };
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = {
      vimrc = "vim $HOME/.config/nvim/init.vim";
      nixrc = "vim /cfg/system/nixos";
    };
    ohMyZsh = let 
      packages = [
        {
          owner = "bhilburn";
          repo = "powerlevel9k";
          rev = "v0.6.3";
          sha256 = "026j7ryzmrqhjd72b0axiz9bi63bfbzl378f9fn7y5g9bdy641qk";
        }
      ];

      fetchToFolder = { repo, ...}@attrs:
        pkgs.fetchFromGitHub (attrs // {
          extraPostFetch = ''
            tmp=$(mktemp -d)
            mv $out/* $tmp
            mkdir $out/${repo}
            mv $tmp/* $out/${repo}
          '';
        });
      custom = pkgs.buildEnv {
        name = "zsh-custom";
        paths = builtins.map fetchToFolder packages;
      };
    in
    {
      enable = true;
      custom = custom.outPath;
      theme = "powerlevel9k/powerlevel9k";
      plugins = [ "git" "pass" "brew" "colored-man" "colorize" ];
    };
    shellInit = ''
      # Simple function to enumerate all snapshots of a directory
      # Example: To list all files of all snapshots of the `dir` directory of the current folder:
      # ls $(snaps dir)
      #
      # To view all versions of a file in vim:
      # vim $(snaps dir)
      function snaps() {
        local mount=$(stat -c '%m' .)
        echo "$mount/.zfs/snapshot/*/$(realpath . --relative-to=$mount)/$1"
      }
    '';
  };

  users.defaultUserShell = pkgs.zsh;
}
