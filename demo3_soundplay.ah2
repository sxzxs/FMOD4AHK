#Requires AutoHotkey v2.0
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
FMOD_OPENMEMORY := 0x00000800
FMOD_LOOP_OFF := 0x00000001

system.FMOD_System_CreateSound('./jaguar.wav', FMOD_DEFAULT, 0, &sound)

system.FMOD_System_PlaySound(sound, 0, false, &channel)

sleep(10000)

sound.FMOD_Sound_Release()
system.FMOD_System_Close()
system.FMOD_System_Release()