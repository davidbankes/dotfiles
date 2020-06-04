#export PATH="$HOME/.composer/vendor/bin:/usr/local/mysql/bin:$HOME/Dev/node_modules/bin:$PATH"

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

source ~/.bashrc


alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# globbing.
#shopt -s extglobexport PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# ANDROID goodness
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
