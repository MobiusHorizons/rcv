/********************************
 * File: main.vala		*
 * Author: Paul Martin		*
 * Date: 03-38-13		*	
 ********************************/

int main (string[] args) {
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
		}
	}
	
	if (cli_bool){
		var cli = new CLI(filename);
		cli.run();
	} else {
		Gtk.init (ref args);
		var calcWin = new main_window(filename);
		calcWin.run();
		Gtk.main();
	}

	
	return 0;
}
