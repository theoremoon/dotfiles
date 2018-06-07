#!/bin/bash

# check does binary exist
# exists --> return 0
# do not exists --> print message and return 1
function check_binary()
{
  which "$1" 1>/dev/null 2>/dev/null
  r=$?
  if [ $r != 0 ]; then
    echo "$1 is not installed"
  fi
  return $r
}

# deploy file (create symlink)
# deploy src dst
# when destination directory does not exist run mkdir
# when destination file already exist remove it
function deploy()
{
  dstdir=$(dirname $2)
  if [ ! -d "$dstdir" ]; then
    mkdir -p "$dstdir" 1>/dev/null 2>/dev/null
    if [ $? != 0 ]; then
      echo "failed to create dir $dstdir"
      return 1
    fi
  fi
  
  ln -sfnv $(realpath $1) $2
}

# deploy directory (recursive run deploy)
# deploy_rec srcdir dstdir
# like cp -r srcdir dstdir but all files are symlink
function deploy_rec()
{
  for p in $(find "$1" -type f); do
   deploy $p "$2/$p"
  done
}

# -- main --
function deploy_all()
{
  fs=$(ls -a | grep -v '\.\+$' | grep -v -E '(util.sh|Makefile|.git)')
  for f in $fs; do
    if [ -f "$f" ]; then
      deploy $f $HOME
    elif [ -d "$f" ]; then
      deploy_rec $f $HOME
    fi
  done
}

case "$1" in
  "all")
    
    ;;
  *)
    deploy_all
    ;;

esac
