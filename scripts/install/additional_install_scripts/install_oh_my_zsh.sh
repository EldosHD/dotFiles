if ! [ -d ~/.oh-my-zsh ]
then
    # install omz
    echo "installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already installed"
fi
