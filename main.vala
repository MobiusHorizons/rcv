/****************************************
 * Reverse Polish Notation Calculator	*
 * File: main.vala			*
 * Author: Paul Martin			*
 * Date: 03-38-13			*	
 ****************************************/

int main (string[] args) {
/**
 * main: start the appropriate UI
 *
 * * parses the command line arguments
 * * loads the appropriate UI based on arguments
**/
	bool cli_bool = false;
	bool file_bool = false;
	string filename = "";

	foreach (unowned string arg in args){
		if (file_bool){
			filename = arg;
		}
		switch (arg){	// parse command line arguments
			case "--cli":
				cli_bool = true;
				break;
			case "-f":
			case "--file":
				file_bool = true;
				break;
			case "--help":
				usage();
				return(0);
				break;
		}
	}
	// run through arguments one by one
 
	if (cli_bool){
		var cli = new CLI(filename);
		cli.run();
		// instantiate a CLI object
		// run it
	} else {
		Gtk.init (ref args); 
		var calcWin = new main_window(filename);
		calcWin.run();
		Gtk.main();
		// start Gtk, and hand it our cli args
		// instantiate and run the main window
		// start the Gtk loop
	}	
	return 0;
}
