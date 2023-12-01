{pkgs, ...}: {
  imports = [];

  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 10;
        draw_bold_text_with_bright_colors = true;
      };
      window.opacity = 0.9;
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

}
