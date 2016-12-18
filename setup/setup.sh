#!/bin/sh

echo "Hello, World!"
echo "setup start"

echo "install xcode build"
sudo xcodebuild -license
sudo xcode-select --install

echo "install Homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew doctor
brew update

echo "install ansible"
brew install ansible
brew install git
brew install zsh

echo "set login shell"
echo "hpass -s /usr/local/bin/zsh"
echo "ssh-keygen -t rsa -C maill"

if [ ! -e ~/.ssh ]; then
    mkdir ~/.ssh
fi
