FROM ubuntu:21.04

# apt install basic apps
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt install vim zsh tmux sudo git wget curl tmux build-essential -y

# config zsh with zsh-autosuggestions and starship
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
RUN echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" > ~/.zshrc
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes -y
RUN echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc
RUN echo $SHELL_RC >> ~/.zshrc

# install kitty terminal
RUN apt install kitty libgl-dev alsa -y
RUN wget https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/ayu_mirage.conf -P ~/.config/kitty/
RUN echo "include ./ayu_mirage.conf" >> ~/.config/kitty/kitty.conf


ENTRYPOINT ["/usr/bin/zsh"]
