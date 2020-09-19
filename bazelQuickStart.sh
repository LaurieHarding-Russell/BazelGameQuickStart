#!/bin/bash

readonly ERROR='\033[0;31m'
readonly INFO='\033[0;34m'
readonly SUCCESS='\033[0;32m'
readonly RESET='\033[0m'

declare -i GRAPHICS_VULKAN=1
declare -i GRAPHICS_NONE=2

declare -i graphics=0

selectGraphicsLibrary(){
    local options=("1. Vulkan" "2. None")
    PS3="Choose a graphics library:"
    select opt in "${options[@]}"; do 

        case "$REPLY" in
        1 | Vulkan ) printf "Using Vulkan\n"
            graphics=$GRAPHICS_VULKAN
            break;
        ;;
        2 | None) printf "Not using a Graphics library\n"
            graphics=$GRAPHICS_NONE
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
    printf "$parent_path/Vulkan/Renderer.cpp\n"
    cp $parent_path/Vulkan/Renderer.cpp $location/$name/Renderer.cpp
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
echo $mainCppFile >> $location/$name/game.cpp

printf "$SUCCESS Done!\n$RESET"