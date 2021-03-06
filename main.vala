/****************************************
 * Reverse Polish Notation Calculator	*
 * File: main.vala			*
 * Author: Paul Martin			*
 * Date: 03-38-13			*	
 ****************************************/


void usage(string name){
/**
 * void usage(): print out usage
**/
	stdout.printf(
"""Usage:
%s [--cli] [-f|--filename file]

	--cli: start in command line mode

	-f
	--filename: load startup file
	This is used mostly for declarations of constants or functions

""",name);
}

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
				usage(args[0]);
				return(0);
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
