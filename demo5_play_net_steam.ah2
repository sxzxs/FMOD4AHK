#Requires AutoHotkey v2.0
#include <fmod>

g_is_play := true
ui := Gui()
ui.AddButton('w100 h50', '播放/暂停').OnEvent('Click', on_button_click)
ui.Show()

;下载
url := 'http://live-radio01.mediahubaustralia.com/2TJW/mp3/'
system := FMOD_system()
sound := FMOD_sound()
sound_to_play := FMOD_sound()
channel := FMOD_channel()

extradriverdata := 0

system.FMOD_System_Init(1, FMOD_INIT_NORMAL := 0x00000000, extradriverdata)

system.FMOD_System_SetStreamBufferSize(64*1024, FMOD_TIMEUNIT_RAWBYTES := 0x00000008)

FMOD_CREATESTREAM := 0x00000080
FMOD_NONBLOCKING := 0x00010000

extern_info := Buffer(224, 0)
NumPut('int', cbsize := extern_info.Size, extern_info, 0)
NumPut('int', filebuffersize := 1024*16, extern_info, 176)
system.FMOD_System_CreateSound(url, FMOD_CREATESTREAM | FMOD_NONBLOCKING, extern_info, &sound)

system.FMOD_System_PlaySound(sound, 0, false, &channel)
loop
{
    if(g_is_play)
    {

    }
    if(!channel.ptr)
        system.FMOD_System_PlaySound(sound, 0, false, &channel)
    Sleep(20)
}

sound.FMOD_Sound_Release()
system.FMOD_System_Close()
system.FMOD_System_Release()

on_button_click(*)
{
    global g_is_play
    g_is_play := !g_is_play
    if(channel.ptr)
    {
        channel.FMOD_Channel_SetPaused(!g_is_play)
    }
}