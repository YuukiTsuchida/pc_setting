######
# パス設定
#####
export NDK_ROOT=$HOME/Library/Developer/android/ndk
export ANDROID_NDK_HOME=$NDK_ROOT
export ANDROID_SDK_ROOT=$HOME/Library/Developer/android/sdk
export ANT_ROOT=/usr/local/bin
export CLANG=$HOME/clang/bin

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/23.0.1
export PATH=$PATH:$NDK_ROOT
export PATH=$PATH:/usr/local/bin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# export PATH=$PATH:/Users/tsuchidayuuki/.omnisharp/omnisharp/bin
#export PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"
#export PATH=/usr/local/opt/php54/bin:$PATH
#export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export PATH=/Users/tsuchidayuuki/.pyenv/bin:$PATH

export NDK_CCACHE=/usr/local/bin/ccache

export XDG_CONFIG_HOME=$HOME/.config

#node
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh


eval "$(pyenv init -)"
export PYENV_ROOT=/Users/tsuchidayuuki/.pyenv
alias brew="env PATH=${PATH/\/Users\/tsuchidayuuki\/.pyenv\/shims:/} brew"

export BITBUCKET=$HOME/Documents/bitbucket/

# xcodeのctagsが有効になるのでaliasで上書き
alias ctags="`brew --prefix`/bin/ctags"
#alias jenkins='java -jar /usr/local/opt/jenkins/libexec/jenkins.war'

# gtags
export GTAGSLABEL=pygments

# GO言語
#
[[ -s "/Users/tsuchidayuuki/.gvm/scripts/gvm" ]] && source "/Users/tsuchidayuuki/.gvm/scripts/gvm"
export GOROOT_BOOTSTRAP=$GOROOT
#export PATH=$GOROOT/bin:$PATH
#export PATH=$GOPATH/bin:$PATH

export PATH=$PATH:$HOME/svm
if [[ -d "${HOME}/.svm/current/rt" ]]; then
	export SCALA_HOME=${HOME}/.svm/current/rt
	export PATH=$PATH:$SCALA_HOME/bin
fi

StartOmniServer()
{
mono $HOME/.vim/bundle/neobundle/plugins/Omnisharp/server/OmniSharp/bin/Debug/OmniSharp.exe -p 2000 -s $1;
}

ChangeClang()
{
    export PATH=$CLANG:$PATH
    alias clang='clang --sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk'
}
# pythonbrew
#if [ -s "$HOME/.pythonbrew/etc/bashrc" ]; then
#    source "$HOME/.pythonbrew/etc/bashrc"
#    # exec command like virtualenvwrapper
#    alias mkvirtualenv="pythonbrew venv create"
#    alias rmvirtualenv="pythonbrew venv delete"
#    alias workon="pythonbrew venv use"
#fi

# IBM Blue Mix
alias bluemix='cf'

# rbenv 設定
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# gitコマンド補完
#source ~/git-completion.bash

# ターミナルでブランチ名を表示
# VCS settings
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' formats "%F{white}%c%u[%b]%f"
precmd() {
     psvar=()
     LANG=en_US.UTF-8 vcs_info
#     psvar[1]=$vcs_info_msg_0_
}
#PROMPT=$'%2F%n@%m%f %3F%~%f%1v\n%# '
setopt prompt_subst
#PROMPT=$'%/%% %f%1v\n%# '
PROMPT=$'%/%% %f%1v''${vcs_info_msg_0_}'$'\n%# '

# ターミナルでmacvimを使用する
#export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
alias vi='vim'
#alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'




#####
# 補完関係の設定
#####
setopt   auto_list auto_param_slash list_packed rec_exact
unsetopt list_beep
zstyle ':completion:*' menu select
zstyle ':completion:*' format '%F{white}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' completer _oldlist _complete _match _ignored \
    _approximate _list _history
autoload -U compinit
compinit -u

#if [ -e $HOME/Documents/github/pc_setting/zsh-completions/src/ ]; then
#	fpath=($HOME/Documents/github/pc_setting/zsh-completions/src $fpath)
#fi


#source ~/.zsh/auto-fu.zsh
#function zle-line-init () {
#    auto-fu-init;
#}
#zle -N zle-line-init
#
#function () {
#    local code
#    code=${functions[auto-fu-init]/'\n-azfu-'/''}
#    eval "function auto-fu-init () { $code }"
#    code=${functions[auto-fu]/fg=black,bold/fg=white}
#    eval "function auto-fu () { $code }"
#}

## auto-fu 有効化
#function zle-line-init () {
#    auto-fu-init
#}

# タブキー連打で補完候補を順に表示
#setopt auto_menu

# 自動修正機能(候補を表示)
setopt correct

# 補完候補を詰めて表示
setopt list_packed

# = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt magic_equal_subst

# 補完候補リストの日本語を正しく表示
setopt print_eight_bit

# lsコマンドの補完候補にも色付き表示
#eval `dircolors`
#zstyle ':completion:*:default' list-colors ${LS_COLORS}
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'


###############################################
# 履歴関係                                    #
###############################################
## ヒストリー機能
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加


###############################################
# その他                                      #
###############################################
setopt no_beep               # ビープ音を消す

## zshのhomebrew補完
#if [ -f ~/.zsh/auto-fu.zsh ]; then
#    source ~/.zsh/auto-fu.zsh
#
#    zle -N zle-line-init
#    zstyle ':completion:*' completer _oldlist _complete
#fi

##zsh設定
##URL:http://d.hatena.ne.jp/tarao/20100531/1275322620
## precompiled source
#function () { # precompile
#    local A
#    A=~/.zsh/modules/auto-fu/auto-fu.zsh
#    [[ -e "${A:r}.zwc" ]] && [[ "$A" -ot "${A:r}.zwc" ]] ||
#    zsh -c "source $A; auto-fu-zcompile $A ${A:h}" >/dev/null 2>&1
#}
#source ~/.zsh/modules/auto-fu/auto-fu; auto-fu-install
#
## initialization and options
#function zle-line-init () { auto-fu-init }
#zle -N zle-line-init
#zstyle ':auto-fu:highlight' input bold
#zstyle ':auto-fu:highlight' completion fg=white
#zstyle ':auto-fu:var' postdisplay ''
#
## afu+cancel
#function afu+cancel () {
#    afu-clearing-maybe
#    ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur"; }
#}
#function bindkey-advice-before () {
#    local key="$1"
#    local advice="$2"
#    local widget="$3"
#    [[ -z "$widget" ]] && {
#        local -a bind
#        bind=(`bindkey -M main "$key"`)
#        widget=$bind[2]
#    }
#    local fun="$advice"
#    if [[ "$widget" != "undefined-key" ]]; then
#        local code=${"$(<=(cat <<"EOT"
#            function $advice-$widget () {
#                zle $advice
#                zle $widget
#            }
#            fun="$advice-$widget"
#EOT
#        ))"}
#        eval "${${${code//\$widget/$widget}//\$key/$key}//\$advice/$advice}"
#    fi
#    zle -N "$fun"
#    bindkey -M afu "$key" "$fun"
#}
#bindkey-advice-before "^G" afu+cancel
#bindkey-advice-before "^[" afu+cancel
#bindkey-advice-before "^J" afu+cancel afu+accept-line

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "/Users/tsuchidayuuki/.gvm/scripts/gvm" ]] && source "/Users/tsuchidayuuki/.gvm/scripts/gvm"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT="/Users/tsuchidayuuki/cocos2d-x-3.17.2/tools/cocos2d-console/bin"
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT="/Users/tsuchidayuuki"
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT="/Users/tsuchidayuuki/cocos2d-x-3.17.2/templates"
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
# export COCOS_CONSOLE_ROOT=/Applications/Cocos/Cocos2d-x/cocos2d-x-3.10/tools/cocos2d-console/bin
# export PATH=$COCOS_CONSOLE_ROOT:$PATH
#
# # Add environment variable COCOS_X_ROOT for cocos2d-x
# export COCOS_X_ROOT=/Applications/Cocos/Cocos2d-x
# export PATH=$COCOS_X_ROOT:$PATH
#
# # Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
# export COCOS_TEMPLATES_ROOT=/Applications/Cocos/Cocos2d-x/cocos2d-x-3.10/templates
# export PATH=$COCOS_TEMPLATES_ROOT:$PATH
