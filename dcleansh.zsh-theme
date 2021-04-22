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
    ruby="$(asdf current ruby | awk -F' ' '{print $2}')"
  fi

  if [[ ! -z "$ruby" ]]; then
    echo -n "[rb-$ruby]"
  fi
}

set_node_version() {
  local node=''

  if which asdf &> /dev/null; then
    node="$(asdf current nodejs | awk -F' ' '{print $2}')"
  fi

  if [[ ! -z "$node" ]]; then
    echo -n "[n-$node]"
  fi
}

set_python_version() {
  local python=''

  if which asdf &> /dev/null; then
    python="$(asdf current python | awk -F' ' '{print $2}')"
  fi

  if [[ ! -z "$python" ]]; then
    echo -n "[py-$python]"
  fi
}

local git_branch='$(git_prompt_info)%{$reset_color%}'

# Update prompt
precmd () {
  psvar[1]="$(set_ruby_version) ";
  psvar[2]="$(set_node_version) ";
  psvar[3]="$(set_python_version)";
}

local print_versions="$fg[cyan]%1v$fg[green]%2v$fg[blue]%3v$reset_color"

PROMPT="$user_host $current_dir $print_versions $git_branch
%B${user_symbol}%b "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}[ "
ZSH_THEME_GIT_PROMPT_SUFFIX=" ] %{$reset_color%}"
