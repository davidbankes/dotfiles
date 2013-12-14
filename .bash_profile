export PATH="/usr/local/mysql/bin:$PATH"

platform='unknown'
hostname='unknown'
unamestr=`uname`
hostnamestr=`uname -n`
if [[ "$unamestr" == 'Linux' ]]; then
	platform='linux'
	if [[ "$hostnamestr" == 'Diskstation' ]]; then
		hostname='diskstation'
	fi
elif [[ "$unamestr" == 'FreeBSD' ]]; then
	platform='freebsd'
fi

[[ -s ~/.bashrc ]] && source ~/.bashrc

