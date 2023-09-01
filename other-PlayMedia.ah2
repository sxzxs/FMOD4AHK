;by tebayaki
;PlayMedia("https://dict.youdao.com/dictvoice?audio=apple")
;http://live-radio01.mediahubaustralia.com/2TJW/mp3/
PlayMedia("http://live-radio01.mediahubaustralia.com/2TJW/mp3/")

PlayMedia(uri) {
    DllCall("Combase\RoActivateInstance", "ptr", CreateHString("Windows.Media.Playback.MediaPlayer"), "ptr*", iMediaPlayer := ComValue(13, 0), "HRESULT")
    iUri := CreateUri(uri)
    ComCall(47, iMediaPlayer, "ptr", iUri) ; SetUriSource
    ComCall(45, iMediaPlayer) ; Play
    loop {
        ComCall(12, iMediaPlayer, "uint*", &state := 0) ; CurrentState
    } until state == 3
    loop {
        ComCall(12, iMediaPlayer, "uint*", &state := 0) ; CurrentState
    } until state == 4
}

CreateUri(str) {
    DllCall("ole32\IIDFromString", "str", "{44A9796F-723E-4FDF-A218-033E75B0C084}", "ptr", iid := Buffer(16), "HRESULT")
    DllCall("Combase\RoGetActivationFactory", "ptr", CreateHString("Windows.Foundation.Uri"), "ptr", iid, "ptr*", factory := ComValue(13, 0), "HRESULT")
    ComCall(6, factory, "ptr", CreateHString(str), "ptr*", uri := ComValue(13, 0))
    return uri
}

CreateHString(str) {
    DllCall("Combase\WindowsCreateString", "wstr", str, "uint", StrLen(str), "ptr*", &hString := 0, "HRESULT")
    return { Ptr: hString, __Delete: (_) => DllCall("Combase\WindowsDeleteString", "ptr", _, "HRESULT") }
}