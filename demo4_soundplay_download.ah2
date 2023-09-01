#Requires AutoHotkey v2.0
#include <fmod>

;下载
url := "https://dict.youdao.com/dictvoice?audio=apple"
mp3 := DownloadRaw(url)

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

extern_info := Buffer(224, 0)
NumPut('int', cbsize := extern_info.Size, extern_info, 0)
NumPut('uint', length := mp3.Size, extern_info, 4)
system.FMOD_System_CreateSound(mp3, FMOD_OPENMEMORY | FMOD_LOOP_OFF, extern_info, &sound)

system.FMOD_System_PlaySound(sound, 0, false, &channel)

sleep(10000)

sound.FMOD_Sound_Release()
system.FMOD_System_Close()
system.FMOD_System_Release()

DownloadRaw(url) 
{
    request := ComObject("WinHttp.WinHttpRequest.5.1")
    request.Open("GET", url, true)
    request.Send()
    request.WaitForResponse()
    sa := request.ResponseBody
    DllCall("OleAut32\SafeArrayAccessData", "ptr", sa, "ptr*", &pData := 0, "HRESULT")
    return {Ptr: pData, Size: sa.MaxIndex() + 1, __Delete: (_) => DllCall("OleAut32\SafeArrayUnaccessData", "ptr", _, "HRESULT")}
}