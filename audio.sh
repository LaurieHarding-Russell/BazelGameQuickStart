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
        2 | None) printf "Not using a Audio library\n"
            graphics=$AUDIO_NONE
            break;
        ;;
        *) printf "$ERROR uhh, maybe try a number like 1 or 2? $RESET\n";
            continue
        ;;
        esac
    done
}