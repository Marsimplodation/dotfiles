import dbus
import json
bus = dbus.SessionBus()



no = False;
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
        print(json.dumps({"Playing": (status == "Playing"), "title": title, "artist": artist, "pic": pic}))
        no=True
    
if not no:
    print(json.dumps({"Playing": False, "title": "none", "artist": "none", "pic": ""}))
