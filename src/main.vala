
namespace Kulintang {

  int main(string[] args){

    Gtk.init (ref args);

    //var window = new Gtk.Window ();
    var volume = new Volume();

    //add(volume);
    volume.show();

     //volume.show();

      volume.destroy.connect(Gtk.main_quit);
      Gtk.main ();
    
    return 0;
  }
}
