#################################
#### Environmental variables ####
#################################

### XDG path
# Local data files location
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
# Local config files location
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
# Local cache location
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}

### Other path fix
# Default GUNPG config directory
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
# Default password store directory
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/password-store"
# Less config file location
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
# Less history file location
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
# Wget config file location
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

### NNN variables
# Bookmark keys
export NNN_BMS="s:~/Pictures/Screenshots;d:~/Downloads;D:~/Documents;p:~/Programs"
# Plugin keys
export NNN_PLUG="t:-_|st"
# Default file opener
export NNN_OPENER="/home/deep/.config/nnn/plugins/file-opener"
# Trash system (1 = trash-cli)
export NNN_TRASH=1
# Archives
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
# File-specific colors
export NNN_FCOLORS='c127e22e006033f7c6d6abc4'
# Context colors
export NNN_COLORS='#0a0b0c0e;1234'


### Default applications
# Default terminal
export TERMINAL="st"
# Default editor
export EDITOR="vim"
# Default browser
export BROWSER="firefox"
# Default Pager
export PAGER="less"
# Default LESS options
export LESS="-R -M --shift 5 --mouse --wheel-lines=10"

### PATH
export PATH="${PATH}:${HOME}/.local/bin"
