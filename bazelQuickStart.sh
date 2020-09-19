#!/bin/bash
readonly ERROR='\033[0;31m'
readonly INFO='\033[0;34m'
readonly SUCCESS='\033[0;32m'
readonly RESET='\033[0m'

mainCppFile="""
"""

buildFile="""
# Generated
"""

workspaceFile="""
# Generated
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")
"""

bazelrcFile=build="""
build --cxxopt=-std=c++17
build --cxxopt -Wno-unused-function
build --cxxopt -Wno-unused-variable
"""

gitignoreFile="""
bazel-*
"""

source otherDependencies.sh
source graphics.sh
source audio.sh


read -p "Project name [game]: " name
name=${name:-game}

read -p "Project location [~]: " location
location=${location:-~}

selectGraphicsLibrary graphics
selectAudioLibrary audio

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
destination=$location/$name
printf "$INFO BUILDING:\n"
printf "at $destination\n$RESET"
# Got to go to our actual location.
printf "I am at $parent_path\n"

mkdir -p $destination
mkdir -p $destination/toolchain
mkdir -p $destination/external

generateGraphicsData


echo $workspaceFile >> $destination/WORKSPACE
echo $buildFile >> $destination/BUILD
echo $gitignoreFile >> $destination/.gitignore
echo $bazelrcFile >> $destination/.bazelrc
echo $mainCppFile >> $destination/Game.cpp

read -p "Basic project setup. Do you want to configure advance settings? (y/n)" advance
advance=${advance:-n}

if [ "$advance" == "y" ]
then
    printf "$ERROR Whoops, still need to code this $RESET\n";
fi
echo $advance

printf "$SUCCESS Done!\n$RESET"