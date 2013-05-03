int main (string[] args) {
	if (args.length > 0 && args[1] == "--cli"){
		var cli = new CLI();
		cli.run();
	} else {
		Gtk.init (ref args);
		var calcWin = new main_window();
		calcWin.run();
		Gtk.main();
	}

	
	return 0;
}
