FROM ubuntu:21.04

# apt install basic apps
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt install vim zsh tmux sudo git wget curl tmux build-essential -y

# config zsh with zsh-autosuggestions and starship
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
RUN echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" > ~/.zshrc
RUN eval $PROXY_COMMANDS
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes -y
RUN echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc
RUN echo $PROXY_COMMANDS >> ~/.zshrc

# install kitty terminal
RUN apt install kitty libgl-dev -y
RUN eval $PROXY_COMMANDS && wget https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/ayu_mirage.conf -P ~/.config/kitty/

RUN echo "include ./kitty-themes/themes/ayu_mirage.conf" >> ~/.config/kitty/kitty.conf


ENTRYPOINT ["/usr/bin/zsh"]
