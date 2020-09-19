#!/bin/bash

source otherDependencies.sh
source graphics.sh

readonly ERROR='\033[0;31m'
readonly INFO='\033[0;34m'
readonly SUCCESS='\033[0;32m'
readonly RESET='\033[0m'

declare -ir AUDIO_OPEN_AL=1
declare -ir AUDIO_NONE=99
declare -i audio=0

selectAudioLibrary() {
    local options=("1. OpenAL" "2. None")
    PS3="Choose an audio library:"
    select opt in "${options[@]}"; do

        case "$REPLY" in 
        1 | OpenAL ) printf "Using OpenAL\n"
            audio=$AUDIO_OPEN_AL
            break;
        ;;
        3 | None) printf "Not using a Audio library\n"
            graphics=$AUDIO_NONE
            break;
        ;;
        *) printf "$ERROR uhh, maybe try a number like 1 or 2? $RESET\n";
            continue
        ;;
        esac
    done
}


read -p "Project name [game]: " name
name=${name:-game}

read -p "Project location [~]: " location
location=${location:-~}

selectGraphicsLibrary graphics

destination=$location/$name

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

printf "$INFO BUILDING:\n"
printf "at $destination\n$RESET"
# Got to go to our actual location.
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
printf "I am at $parent_path\n"

mkdir -p $location/$name
mkdir -p $location/$name/toolchain
mkdir -p $location/$name/external

if [ "$graphics" == "$GRAPHICS_VULKAN" ] 
then
    printf "$INFO Adding Vulkan stuff $RESET\n"
    mainCppFile=$(<$parent_path/Vulkan/Game.cpp)
    cp $parent_path/Vulkan/Renderer.h $location/$name/Renderer.h
    cp -R $parent_path/Vulkan/external/. $location/$name/external
    cp -R $parent_path/Vulkan/shaders/. $location/$name/shaders
    cp -R $parent_path/Vulkan/toolchain/. $location/$name/toolchain
    buildFile=$buildFile$(<$parent_path/Vulkan/BUILD)
    workspaceFile=$workspaceFile$(<$parent_path/Vulkan/WORKSPACE)
fi


echo $workspaceFile >> $location/$name/WORKSPACE
echo $buildFile >> $location/$name/BUILD
echo $gitignoreFile >> $location/$name/.gitignore
echo $bazelrcFile >> $location/$name/.bazelrc
echo $mainCppFile >> $location/$name/Game.cpp

read -p "Basic project setup. Do you want to configure advance settings? (y/n)" advance
advance=${advance:-n}

if [ "$advance" == "y" ]
then
    printf "$ERROR Whoops, still need to code this $RESET\n";
fi
echo $advance

printf "$SUCCESS Done!\n$RESET"