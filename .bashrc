PATH=$PATH:/opt/intel/compilers_and_libraries/linux/bin/intel64/ifort
export PATH

# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# general
alias ll='ls -al'
alias ll='ls -lX --block-size=M'
alias del='rm -rf'
alias ..='cd ..'
alias v3='vim ~/.i3/config'
alias v3status='vim ~/.i3status.conf'
alias vv='vim ~/.vimrc'
alias vb='vim ~/.bashrc'
alias gs='git status'
alias ga='git add'
alias gpu='git push'
alias gc='git commit -m'
alias open='xdg-open'
alias hibernate='sudo pm-hibernate'
# physics
alias gp='gnuplot'
alias mkrun='make && ./run'
alias mc='make clean'
alias mcm='make clean && make'
alias cdcode='cd /mnt/files/Data/TU_Berlin/Masterarbeit/code/'
alias cdp='cd /mnt/files/Data/TU_Berlin/Masterarbeit/code/simulation/post_process'
alias cden='cd /mnt/files/Data/TU_Berlin/Masterarbeit/code/simulation/energy_process'
alias cdsp='cd /mnt/files/Data/TU_Berlin/Masterarbeit/code/simulation/spectral_process'
alias cdth='cd /mnt/files/Data/TU_Berlin/Masterarbeit/thesis'
alias cdr='cd /mnt/files/Data/TU_Berlin/Masterarbeit/code/simulation/results/tmp'
alias cdposter='cd /mnt/files/Data/TU_Berlin/Masterarbeit/DPG/Poster/DPG'
alias math='ssh hess@cluster-i.math.tu-berlin.de'
alias gate='ssh phess@gate.rzg.mpg.de'
alias draco='ssh draco'
alias gamling='ssh p.hess@gamling.physik.tu-berlin.de'
alias matha='ssh hess@cluster-a.math.tu-berlin.de'
alias omdraco='scp -r p.hess@gamling.physik.tu-berlin.de:~/code/simulation/plots/draco/* /mnt/files/Data/TU_Berlin/Masterarbeit/code/simulation/plots/draco/'
alias ommath='scp -r p.hess@gamling.physik.tu-berlin.de:~/code/simulation/plots/math/* /mnt/files/Data/TU_Berlin/Masterarbeit/code/simulation/plots/math/'
alias omgam='scp -r p.hess@gamling.physik.tu-berlin.de:~/code/simulation/plots/gam/* /mnt/files/Data/TU_Berlin/Masterarbeit/code/simulation/plots/gam/'
alias fp='scp p.hess@gamling.physik.tu-berlin.de:/home/gamling/p.hess/Masterarbeit/Thesis/tables/forcing* /mnt/files/Data/TU_Berlin/Masterarbeit/thesis/tables/'

function scp2math()
{
    scp $1 hess@cluster-i.math.tu-berlin.de:/work/hess/$2
}

function pptables2thesis()
{   
    /bin/cp -rf /mnt/files/Data/TU_Berlin/Masterarbeit/code/simulation/post_process/data/sim_$1/tables/* /mnt/files/Data/TU_Berlin/Masterarbeit/thesis/tables/ ;
}
 
function entables2thesis()
{   
    /bin/cp -rf /mnt/files/Data/TU_Berlin/Masterarbeit/code/simulation/energy_process/tables/*$1* /mnt/files/Data/TU_Berlin/Masterarbeit/thesis/tables/ ;
}

function search(){ egrep -ir -nr "$1";}

function ppfrommath()
{
   scp -r hess@cluster-a.math.tu-berlin.de:/work/hess/post_process/data/$1 ./$2 ;
}

function mhdfrommath()
{
   scp -r hess@cluster-a.math.tu-berlin.de:/work/hess/linedeform_mhd/diagoutput/$1 ./$2 ;
}

function mhd64frommath()
{
   scp -r hess@cluster-a.math.tu-berlin.de:/work/hess/linedeform_mhd_64/diagoutput/$1 ./$2 ;
}

function mhd_energy_frommath()
{
   scp -r hess@cluster-a.math.tu-berlin.de:/work/hess/linedeform_mhd/diagoutput/$1/energy.000 ./$1/ ;
}

function hdfrommath()
{
   scp -r hess@cluster-a.math.tu-berlin.de:/work/hess/linedeform_dh/diagoutput/$1 ./ ;
}

function frommath()
{
   scp -r hess@cluster-a.math.tu-berlin.de:/work/hess/results/tmp/$1 ./$1 ;
}

function dracofromgamling()
{
   scp -r p.hess@gamling.physik.tu-berlin.de:~/code/simulation/plots/draco/* ./$1 ;
}

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
                if [[ -f ~/.dir_colors ]] ; then
                        eval $(dircolors -b ~/.dir_colors)
                elif [[ -f /etc/DIR_COLORS ]] ; then
                        eval $(dircolors -b /etc/DIR_COLORS)
		else
			eval $(dircolors)
                fi
        fi

        parse_git_branch() {
                 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
        }


        if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] $(parse_git_branch)\[\033[00m\]\$'

        else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[00m\]$(parse_git_branch)\$'
        fi

        alias ls='ls --color=auto'
        alias grep='grep --colour=auto'
else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
                PS1='\u@\h \W \$ '
        else
                PS1='\u@\h \w \$ '
        fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

/usr/bin/mint-fortune
