local user_host='%{$terminfo[bold]$fg[green]%}$(whoami)%{$reset_color%}'
local user_symbol='$'

local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'

set_ruby_version() {
  local ruby=''

  if which rvm-prompt &> /dev/null; then
    ruby="$(rvm-prompt i v g)"
  elif which rbenv &> /dev/null; then
    ruby="$(rbenv version-name)"
  elif which asdf &> /dev/null; then
    asdf_ruby_ver=`asdf current ruby | awk -F' ' '{print $1}'`
    ruby="$asdf_ruby_ver"
  fi

  echo -n "[$ruby]"
}

set_node_version() {
  local node=''

  if which asdf &> /dev/null; then
    asdf_node_ver=`asdf current nodejs | awk -F' ' '{print $1}'`
    node="$asdf_node_ver"
  fi

  echo -n "[$node]"
}

local git_branch='$(git_prompt_info)%{$reset_color%}'

# Update prompt
precmd () {
  psvar[1]=$(set_ruby_version);
  psvar[2]=$(set_node_version);
}
PROMPT="${user_host} ${current_dir} $fg[cyan]%1v $fg[green]%2v$reset_color ${git_branch}
%B${user_symbol}%b "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}[ "
ZSH_THEME_GIT_PROMPT_SUFFIX=" ] %{$reset_color%}"
