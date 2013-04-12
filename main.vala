int main (string[] args) {
	Gtk.init (ref args);
	var calcWin = new main_window();
	calcWin.run();
	Gtk.main();

	
	return 0;
}
