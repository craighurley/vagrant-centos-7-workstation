#!/usr/bin/env bash

set -ex

SUCCESS_INDICATOR=/opt/.vagrant_provision_dotfiles_success

# confirm this is a centos box
[[ ! -f /etc/centos-release ]] && exit 1

# check if provision script has run before
[[ -f $SUCCESS_INDICATOR ]] && exit 0

# .inputrc
cat << EOF > /home/vagrant/.inputrc
# Turn off bell
set bell-style none

# Make Tab autocomplete regardless of filename case
set completion-ignore-case on

# List all matches in case multiple possible completions are possible
set show-all-if-ambiguous on

# Immediately add a trailing slash when autocompleting symlinks to directories
set mark-symlinked-directories on

# Use the text that has already been typed as the prefix for searching through
# commands (i.e. more intelligent Up/Down behaviour)
"\e[B": history-search-forward
"\e[A": history-search-backward

# Do not autocomplete hidden files unless the pattern explicitly begins with a dot
set match-hidden-files off

# Show all autocomplete results at once
set page-completions off

# If there are more than 200 possible completions for a word, ask to show them all
set completion-query-items 200

# Show extra file information when completing
set visible-stats on
EOF

chown vagrant:vagrant /home/vagrant/.inputrc

# create file on provision success
touch $SUCCESS_INDICATOR

exit 0
