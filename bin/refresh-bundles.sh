#!/bin/sh
set -xe

# L9
VIM_L9_URL=https://bitbucket.org/ns9tks/vim-l9/get/tip.tar.gz
VIM_L9_DIR=bundle/vim-l9
rm -rf $VIM_L9_DIR
curl $VIM_L9_URL | \
    tar -s "|ns9tks-vim-l9-[^/]*|$VIM_L9_DIR|" -zxvf -

# FuzzyFinder
VIM_FUZZYFINDER_URL=https://bitbucket.org/ns9tks/vim-fuzzyfinder/get/tip.tar.gz
VIM_FUZZYFINDER_DIR=vim-fuzzyfinder
rm -rf $VIM_FUZZYFINDER_DIR
curl $VIM_FUZZYFINDER_URL | \
    tar -s "|ns9tks-vim-fuzzyfinder-[^/]*|$VIM_FUZZYFINDER_DIR|" -zxvf -
