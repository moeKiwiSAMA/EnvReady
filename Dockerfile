FROM ubuntu:21.04

# apt install basic apps
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt install vim zsh tmux sudo git wget curl tmux -y

# config zsh with zsh-autosuggestions and starship
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
RUN echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" > ~/.zshrc
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes -y
RUN echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc
RUN echo $SHELL_RC >> ~/.zshrc

# install kitty terminal
RUN apt install kitty libgl-dev alsa -y

RUN sed -i 's!root:x:0:0:root:/root:/bin/bash!root:x:0:0:root:/root:/usr/bin/zsh!g' /etc/passwd
RUN wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf -P /local/share/fonts
RUN wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete.ttf -P /local/share/fonts 

RUN mkdir -p ~/.config/kitty
RUN touch ~/.config/kitty/kitty.conf
RUN echo "font_family	FiraCode Nerd Font" >> ~/.config/kitty/kitty.conf
RUN echo "font_size	13.0" >> ~/.config/kitty/kitty.conf

RUN wget https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/ayu_mirage.conf -P ~/.config/kitty/
RUN echo "include ./ayu_mirage.conf" >> ~/.config/kitty/kitty.conf

# pfetch
RUN wget https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch -P /bin
RUN chmod 755 /bin/pfetch
RUN echo "pfetch" >> ~/.zshrc


ENTRYPOINT ["/usr/bin/zsh"]
