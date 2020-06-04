alias sshnas='ssh admin@nas.davidthinking.com'
alias sshneik='ssh neikenberry@pierce.dreamhost.com'

alias dnsflush='sudo discoveryutil mdnsflushcache;sudo discoveryutil udnsflushcaches'

export PATH="$HOME/.composer/vendor/bin:/usr/local/bin:/usr/local/mysql/bin:$HOME/Dev/node_modules/bin:$PATH"


# User specific aliases and functions

alias sassy='sass --watch sass/style.scss:style.css --style compressed'
alias mine='sudo chown -R dbankes:developers *'

alias vtail='vagrant exec sudo tail -f /var/log/httpd/error_log'

alias phpcc='php -dzend_extension=xdebug.so vendor/bin/phpunit --coverage-html tests/Output/'

complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


source ~/dotfiles/git-completion.bash

# User specific aliases and functions

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\H\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \t\n$ "
export SUDO_PS1="\[\033[31m\]\u\[\033[00m\]@\H\w\n$ \t";
export COMPOSER_HOME="~/.composer"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# for slate setup for shopify
function ssl-check() {
    f=~/.localhost_ssl;
    ssl_crt=$f/server.crt
    ssl_key=$f/server.key
    b=$(tput bold)
    c=$(tput sgr0)

    local_ip=$(ipconfig getifaddr $(route get default | grep interface | awk '{print $2}'))
    # local_ip=999.999.999 # (uncomment for testing)

    domains=(
        "localhost"
        "$local_ip"
    )

    if [[ ! -f $ssl_crt ]]; then
        echo -e "\n🛑  ${b}Couldn't find a Slate SSL certificate:${c}"
        make_key=true
    elif [[ ! $(openssl x509 -noout -text -in $ssl_crt | grep $local_ip) ]]; then
        echo -e "\n🛑  ${b}Your IP Address has changed:${c}"
        make_key=true
    else
        echo -e "\n✅  ${b}Your IP address is still the same.${c}"
    fi

    if [[ $make_key == true ]]; then
        echo -e "Generating a new Slate SSL certificate...\n"
        count=$(( ${#domains[@]} - 1))
        mkcert ${domains[@]}

        # Create Slate's default certificate directory, if it doesn't exist
        test ! -d $f && mkdir $f

        # It appears mkcert bases its filenames off the number of domains passed after the first one.
        # This script predicts that filename, so it can copy it to Slate's default location.
        if [[ $count = 0 ]]; then
            mv ./localhost.pem $ssl_crt
            mv ./localhost-key.pem $ssl_key
        else
            mv ./localhost+$count.pem $ssl_crt
            mv ./localhost+$count-key.pem $ssl_key
        fi
    fi
}