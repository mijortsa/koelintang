using Gtk;
using Notify;

public class Volume : Gtk.Window {
    public int volume = 100;
    Notify.Notification indicator;
    Box box;
    Box space;
    Box volume_box;
    Image volume_icon;
    Scale scale_volume;

    Pulse.Stream stream;
    Pulse.StreamContainer stream_container;

    public Volume () {
		get_style_context().add_class("manokwari-panel-sidebar");
		get_style_context().remove_class("background");
        set_keep_above (true);
        set_type_hint (Gdk.WindowTypeHint.POPUP_MENU);
        set_title ("Koelintang");
        set_size_request(240, 60);
		move (1100,0);

        stream = new Pulse.Stream();
        stream_container = new Pulse.StreamContainer(Pulse.StreamType.SINK);
       
        var box = new Box (Gtk.Orientation.VERTICAL, 0);
		add (box);
        volume_box = new Box (Gtk.Orientation.HORIZONTAL, 10);
        volume_box.set_margin_left (20);
        volume_box.set_margin_right (20);
        volume_icon = new Image.from_icon_name ("audio-volume-high-symbolic", IconSize.LARGE_TOOLBAR);
        scale_volume = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 0, 100, 1);
        scale_volume.set_name ("VolumeScale");
        scale_volume.set_value (volume);
        scale_volume.set_draw_value (false);
        scale_volume.value_changed.connect (volume_changed);
        volume_box.pack_start (volume_icon, false, false, 1);
        volume_box.pack_end (scale_volume, true, true, 0);
        volume_box.show_all ();

        space = new Box (Gtk.Orientation.VERTICAL, 0);
        space.show_all ();

        box.pack_start (space, false, false, 4);
        box.pack_start (volume_box, false, false, 10);
        box.show ();
    }

    public void volume_changed (Gtk.Range scale) {
        int volume = (int)scale.get_value();
        stream_container.set_muted (stream, false);
        stream_container.set_volume (stream, volume);

        string name;
        volume_box.remove (volume_icon);

        if (volume == 0) {
            name = "audio-volume-muted-symbolic";
        } else if (volume > 0 && volume <= 33) {
            name = "audio-volume-low-symbolic";
        } else if (volume > 33 && volume <= 66) {
            name = "audio-volume-medium-symbolic";
        } else {
            name = "audio-volume-high-symbolic";
        }

        volume_icon = new Image.from_icon_name (name, IconSize.LARGE_TOOLBAR);
        volume_box.pack_start (volume_icon, false, false, 1);
        volume_box.show_all ();

        indicator = new Notify.Notification("Manokwari", "", name);
        indicator.set_timeout(5);
        Notify.init ("Manokwari");
    }

}
