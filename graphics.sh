declare -ir GRAPHICS_VULKAN=1
declare -ir GRAPHICS_OPEN_GL=2
declare -ir GRAPHICS_NONE=99
declare -i graphics=0

selectGraphicsLibrary() {
    local options=("1. Vulkan" "2. OpenGL" "3. None")
    PS3="Choose a graphics library:"
    select opt in "${options[@]}"; do 

        case "$REPLY" in
        1 | Vulkan ) printf "Using Vulkan\n"
            graphics=$GRAPHICS_VULKAN
            break;
        ;;
        2 | OpenGL ) printf "Using OpenGL\n"
            graphics=$GRAPHICS_OPEN_GL
            break;
        ;;
        3 | None) printf "Not using a Graphics library\n"
            graphics=$GRAPHICS_NONE
            break;
        ;;
        *) printf "$ERROR uhh, maybe try a number like 1 or 2? $RESET\n";
            continue
        ;;
        esac
    done
}