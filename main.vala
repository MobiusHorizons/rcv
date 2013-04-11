int main (string[] args) {
	Gtk.init (ref args);
	var calcWin = new main_window();
	calcWin.destroy.connect(Gtk.main_quit);
	calcWin.show_all();
	Gtk.main();

	
	return 0;
}
