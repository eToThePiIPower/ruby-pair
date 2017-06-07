FROM ubuntu:17.04
MAINTAINER Charles Beynon <etothepiipower@gmail.com>

# Start by changing the apt output, as stolen from Discourse's Dockerfiles.
RUN echo "debconf debconf/frontend select Teletype" | debconf-set-selections &&\
# Probably a good idea
    apt-get update &&\

# Nobody is happy when these aren't up-to-date
    apt-get install -y ca-certificates &&\

# Basic dev tools
    apt-get install -y sudo openssh-client git build-essential vim ctags man curl direnv software-properties-common &&\

# Set up for pairing with wemux.
    apt-get install -y tmux tmate &&\

# Install Homesick, through which dotfile configurations will be installed
    apt-get install -y ruby &&\
    gem install homesick --no-document &&\

# Install the Github Auth gem, which will be used to get SSH keys from GitHub
# to authorize users for SSH
    gem install github-auth --no-document &&\

# Install a couple of helpful utilities
    apt-get install -y ack-grep &&\
    gem install git-duet --no-document &&\
    # gem install rubocop &&\

# Set up SSH. We set up SSH forwarding so that transactions like git pushes
# from the container happen magically.
    apt-get install -y openssh-server &&\
    mkdir /var/run/sshd &&\
    echo "AllowAgentForwarding yes" >> /etc/ssh/sshd_config &&\

# Fix for occasional errors in perl stuff (git, ack) saying that locale vars
# aren't set.
    apt-get install -y locales &&\
    locale-gen --purge en_US.UTF-8 &&\
    update-locale LANG=en_US.UTF-8 &&\

# Add yarn for easy node package management
    apt-get install -y yarn

# Add a nonroot user for development work and add to sudoers
RUN useradd dev -d /home/dev -m -s /bin/bash &&\
    adduser dev sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER dev

ADD ssh_key_adder.rb /usr/local/bin/ssh_key_adder.rb

RUN \
    # Install rvm
    gpg --keyserver hkp://keys.gnupg.net\
        --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 &&\
    curl -sSL https://get.rvm.io | bash &&\
    bash -ic "rvm install 2.4.1" &&\
    bash -ic "rvm --default use 2.4.1" &&\

    # Install nvm
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash &&\
    bash -ic "nvm install lts/boron" &&\

    # Install bashit
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash-it | bash &&\
    /home/dev/.bash-it/install.sh -sn

# Personalization Opetions
RUN \
    # Set up dotfiles
    rm /home/dev/.bashrc &&\
    homesick clone etothepiipower/ruby-pair &&\
    homesick symlink ruby-pair --force &&\
    vim +PlugInstall +qall &&\

    # Enable bash-it plugins
    bash -ic "bash-it enable plugin alias-completion base dirs git hub node nvm rails ruby rvm tmux" &&\
    bash -ic 'bash-it enable alias git tmux' &&\
    bash -ic 'bash-it enable completion dirs git hub rvm rails tmux'

# Expose SSH
EXPOSE 22

# Install the SSH keys of ENV-configured GitHub users before running the SSH
# server process. See README for SSH instructions.
CMD /usr/local/bin/ssh_key_adder.rb && sudo /usr/sbin/sshd -D
