# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
export HISTTIMEFORMAT=" %a %b %d - %r "

# User specific aliases and functions
#------------------

alias set_verint_base_here='export VERINT_BASE=$(pwd)'
alias set_slow_path_base_here='export SLOW_PATH_BASE=$(pwd)'

#load Slow-Path Enviroment and Scripts
export SB_ENV="slow-path"
#export SB_ENV="fast-path"
source $HOME/.silver-bullet

# local aliases
if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi

if [ -f $HOME/.my-custom-env ]; then
    source $HOME/.my-custom-env
fi
source /usr/confd/confd-alias.sh
source $HOME/.services-aliases.sh
export M2_HOME=/opt/apache-maven-3.2.1
export M2=$M2_HOME/bin
export PATH=$M2:$PATH
   
