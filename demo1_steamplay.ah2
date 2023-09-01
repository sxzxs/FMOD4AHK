#include <fmod>

system := FMOD_system()
sound := FMOD_sound()
sound_to_play := FMOD_sound()
channel := FMOD_channel()


extradriverdata := 0

system.FMOD_System_Init(32, FMOD_INIT_NORMAL := 0x00000000, extradriverdata)
FMOD_DEFAULT:= 0x00000000
FMOD_LOOP_NORMAL := 0x00000002
FMOD_2D := 0x00000008

buf := FileRead('./wave_vorbis.fsb', "RAW")
;system.FMOD_System_CreateStream(buf, FMOD_LOOP_NORMAL | FMOD_2D, 0, &sound)
system.FMOD_System_CreateStream('./wave_vorbis.fsb', FMOD_LOOP_NORMAL | FMOD_2D, 0, &sound)

sound.FMOD_Sound_GetNumSubSounds(&numsubsounds := 0)
if(numsubsounds)
{
    sound.FMOD_Sound_GetSubSound(0, &sound_to_play)
}
else
{
    sound_to_play := sound
}

system.FMOD_System_PlaySound(sound_to_play, 0, false, &channel)

sleep(10000)

sound.FMOD_Sound_Release()
system.FMOD_System_Close()
system.FMOD_System_Release()