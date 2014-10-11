alias sshnas='ssh admin@nas.davidthinking.com'
alias sshneik='ssh neikenberry@pierce.dreamhost.com'

alias dnsflush='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'



# User specific aliases and functions

alias sassy='sass --watch sass/style.scss:style.css --style compressed'
alias mine='sudo chown -R dbankes:developers *'



complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\H\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n$ "
export SUDO_PS1="\[\033[31m\]\u\[\033[00m\]@\H\w\n$ ";