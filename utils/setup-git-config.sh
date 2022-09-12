#!/bin/bash

function setup-git-config() {
  local CURRENT_DIR=$(pwd)
  local GIT_USER_EMAIL=""
  local GIT_USER_NAME=""

  cd $HOME
  cat << EOF > .gitconfig
  [user]
    email = $GIT_USER_EMAIL
    name = $GIT_USER_NAME

  [core]
    editor = vim
    autocrlf = input

  [color "status"]
    added = green
    changed = cyan 
    untracked = yellow
    deleted = red

  [color "branch"]
    current = white 
    remote = red 

  [color "diff"]
    meta = yellow 
    old = red 
    new = green

  [alias]
    s = !git status -s
    c = !git add --all && git commit -m
    cl = !git add --all && git commit
    l = !git log --pretty=format:'%C(blue)%h %C(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'
    cm = checkout master
    cb = checkout -b
    st = status -sb
    sf = show --name-only
    lg = log --pretty=format:'%Cred%h%Creset %C(bold)%cr%Creset %Cgreen<%an>%Creset %s' --max-count=30
    incoming = !(git fetch --quiet && git log --pretty=format:'%C(yellow)%h %C(white)- %C(red)%an %C(white)- %C(cyan)%d%Creset %s %C(white)- %ar%Creset' ..@{u})
    outgoing = !(git fetch --quiet && git log --pretty=format:'%C(yellow)%h %C(white)- %C(red)%an %C(white)- %C(cyan)%d%Creset %s %C(white)- %ar%Creset' @{u}..)
    unstage = reset HEAD --
    undo = checkout --
    rollback = reset --soft HEAD~1
EOF
  cd $CURRENT_DIR
}