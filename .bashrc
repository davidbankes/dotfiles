alias sshdev='ssh dbankes@dev01.spiiider.com'
alias sshstage='ssh dbankes@172.16.9.2'
alias sshlive='ssh dbankes@172.16.9.1'
alias sshnas='ssh admin@nas.davidthinking.com'
alias sshneik='ssh neikenberry@pierce.dreamhost.com'

alias dnsflush='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp