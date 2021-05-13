#!/bin/bash
# By @hiukky https://hiukky.com

THEME=Kripton
THEME_DIR=$HOME/.themes/$THEME

set -eE
printf "\nBuilding...\n\n"

rm -rf dist && mkdir dist

yarn gulp styles

rsync -r --verbose --exclude={Art,dist,node_modules,src,Gulpfile.js,build.sh,*.scss,*.json,*.lock} ./* ./dist
find ./dist -type d -empty -delete

printf "\nInstalling..."

rm -rf $THEME_DIR && mkdir -p $THEME_DIR
cp -r ./dist/* $THEME_DIR

gsettings set org.gnome.desktop.interface gtk-theme $THEME
gsettings set org.gnome.desktop.wm.preferences theme $THEME

printf "\n\nSuccess!\n\n"