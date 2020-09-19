#!/bin/bash

ERROR='\033[0;31m'
INFO='\033[0;34m'
SUCCESS='\033[0;32m'
RESET='\033[0m'

selectGraphicsLibrary(){
    local chosen = "None"
    local options=("1. Vulkan" "2. None")
    PS3="Choose a graphics library"
    select opt in "${options[@]}"; do 

        case "$REPLY" in
        1 )
        Vulkan ) printf "Adding Vulkan"
            chosen = "Vulkan";
            break;
        ;;
        2 )
        None) printf "Not using a Graphics library"
            break;
        ;;
        *) printf "$ERROR uhh, maybe try a number like 1 or 2? $RESET";
            continue
        ;;
        esac
    done

    eval $__resultvar="'$myresult'"
}


read -p "Project name [game]: " name
name=${name:-game}

read -p "Project location [~/]: " location
location=${location:-~/}

selectGraphicsLibrary graphics

destination=$location/$name
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
mkdir -p $location/$name
mkdir -p $location/$name/toolchain
mkdir -p $location/$name/external

if [graphics eq "Vulkan"] 
then
    cp ./Vulkan/Game.cpp $location/$name/Game.cpp
    cp ./Vulkan/Renderer.cpp $location/$name/Renderer.cpp
    cp -R ./Vulkan/external/. $location/$name/external
    cp -R ./Vulkan/shaders/. $location/$name/shaders
    cp -R ./Vulkan/toolchain/. $location/$name/toolchain
    buildFile=$(<./Vulkan/BUILD)
    workspaceFile=$(<./Vulkan/WORKSPACE)
fi


echo workspaceFile >> $location/$name/WORKSPACE
echo buildFile >> $location/$name/BUILD
echo gitignoreFile >> $location/$name/.gitignore
echo bazelrcFile >> $location/$name/.bazelrc

printf "$SUCCESS Done!\n$RESET"