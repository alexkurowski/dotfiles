alias apt-i="sudo apt install"
alias apt-upd="sudo apt update"
alias apt-upg="sudo apt update && sudo apt dist-upgrade"
alias apt-r="sudo apt remove"
alias apt-p="sudo apt purge"
alias apt-add="sudo apt-add-repository"

alias wrk="cd ~/Work/"
alias prj="cd ~/Projects/"

alias kae="killall -e"

alias gitlg="git log --graph --decorate"
alias gits="git status"
alias gitss="git status -s"
alias gitall="git add --all"
alias gitd="git diff"
alias gitdd="git diff --cached"
alias gitupd="git commit -m 'Update'"

alias npms="npm start"
alias npmd="npm run dev"
alias npmdd="npm run dev!"
alias npmb="npm run build"
alias npmt="npm run test"
alias npml="npm run lint"

alias yarnd="yarn dev"
alias yarndd="yarn dev!"
alias yarns="yarn start"
alias yarnb="yarn build"
alias yarnt="yarn test"
alias yarnl="yarn lint"

alias phx="iex -S mix phx.server"
alias phx-reset="mix ecto.drop && mix ecto.create && mix ecto.migrate && mix run priv/repo/seeds.exs && iex -S mix phx.server"

alias openfl="haxelib run openfl"
alias fl="openfl"

alias be="bundle exec"

alias firefox-dev="~/bin/firefox/firefox"

alias tmux="tmux -2"

alias nvimn="nvim '+NvimTreeOpen'"

alias mk=make

alias la="ls -a"

alias grepe="grep -r . -E -e"
alias grepapp="grep -r app -E -e"
alias grepapps="grep -r apps -E -e"
alias greplib="grep -r lib -E -e"
alias grepsrc="grep -r src -E -e"
alias grephere="grep -r . --exclude-dir=node_modules -E -e"
alias grepi="grep -r internal -E -e"

alias sedhere="find . -type f -print0 | xargs -0 sed"

alias pdoc="pandoc -t plain"

alias sbcl="rlwrap sbcl"
alias urn="lua /Users/mapi/Projects/lua/urn/bin/urn.lua"

alias k8s="kubectl"

alias love="/Applications/love.app/Contents/MacOS/love"

alias switch-arm="env /usr/bin/arch -arm64 /bin/zsh --login"
alias switch-x86="env /usr/bin/arch -x86_64 /bin/zsh --login"

alias servehere="python3 -m http.server 3000"
