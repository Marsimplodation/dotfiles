import dbus
import json
import os
from PIL import Image, ImageFilter
bus = dbus.SessionBus()



no = False;

def blur_img(pic_path):
    if not os.path.exists(pic_path):
        return pic_path  # fallback if file missing
    im = Image.open(pic_path)
    output_path = "/tmp/cover_blur.png"
    blurred = im.filter(ImageFilter.GaussianBlur(10))
    blurred.save(output_path)
    return output_path

for service in bus.list_names():
    if service.startswith('org.mpris.MediaPlayer2.'):
        player = dbus.SessionBus().get_object(service, '/org/mpris/MediaPlayer2')

        status=player.Get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus', dbus_interface='org.freedesktop.DBus.Properties').replace("dbus.String(", "").split(",")[0]

        metadata = player.Get('org.mpris.MediaPlayer2.Player', 'Metadata', dbus_interface='org.freedesktop.DBus.Properties')
        title = metadata.get('xesam:title').replace("dbus.String(", "").split(",")[0]
        artist = metadata.get('xesam:artist')[0].replace("dbus.String(", "")
        pic = metadata.get('mpris:artUrl')
        if not pic == None:
            pic = pic.replace("dbus.String(", "").split(",")[0]
            pic = pic.replace("file://", "")
        print(json.dumps({"Playing": (status == "Playing"), "title": title, "artist": artist, "cover": pic, "cover_blured": blur_img(pic)}))
        no=True
    
if not no:
    print(json.dumps({"Playing": False, "title": "none", "artist": "none", "cover": "", "cover_blurred": ""}))
