/****************************************
 * Reverse Polish Notation Calculator	*
 * File: window.vala			*
 * Description: Defines the Main window *
 *	A sublcass of Gtk.Window	*
 * Author: Paul Martin			*
 * Date:   03-28-13			*
 ****************************************/

using Gtk; 		// Use these namespaces
using GLib;		

public class main_window: Window {
/**
 * The main window class:
	* has it's own instance of the calculator/interpreter and UI elements
 **/
	private Gtk.TextView Out;
	private Gtk.Entry In;
	private Gtk.Button Enter;
	private rpn myCalc;

	private inline bool getln (out string line, FileStream str = stdin){  
/**
	Used by the preload method to read lines from the file. just a useful method.
**/
			line = str.read_line();
		if ( !str.eof() && line != null){ 
			return true;
		} else {
			return false;
		}
	}

	private void preload(string filename){
/**
	Method to run lines of the file through the calculator instance. 
	It cannot happen in main because we don't have the calculator/interpreter instance defined yet.
**/
		var file = FileStream.open(filename,"r");
		string line = "";
		int i = 0;
		while(getln(out line, file)){
			i++;
			try {
				this.myCalc.calc(line);
			} catch (CalcError e){
				this.Out.buffer.text = "Error: %s".printf(e.message);
				stderr.printf("Error: in %s, on line %d, %s", filename,i,e.message);
			}
		}
	}

	public main_window(string filename=""){
/**
 * Constructor for main window.
 *
 *  * filename is passed to preload()
 *  * sets up graphical area.
 *  * initializes class variables
**/
		this.title = "Rpn Calculator";
		this.border_width = 10;
		this.window_position=WindowPosition.CENTER;
		this.set_default_size(500,400);
		// Basic window setup

		this.Out = new TextView();
		this.Out.editable=false;
		this.Out.can_focus=false;
		// Instantiating and configuring the TextView

		this.In = new Entry();
		// Instantiating the Text Entry

		this.Enter = new Button.with_label("Enter");
		// Instantiate the "enter" button

		var hbox = new Box (Orientation.HORIZONTAL,2);
		var vbox = new Box (Orientation.VERTICAL,2);
		// Declare the new boxes that subdivide the window, and hold the widgets

		this.Enter.clicked.connect(on_enter);
		this.In.activate.connect(on_enter);
		// connect callbacks to both the button and the text entry
		
		this.key_press_event.connect ((e) => {
/**
 * key overrides
 * 
 * this section overrides the keys for '+' '-' '*' '/' and enter on the numpad
 * this way they automatically add an enter action at the end of them
*/
			switch (e.keyval) {
				case Gdk.Key.KP_Add:
					this.In.text += " +";
					on_enter();
					return true;
				case Gdk.Key.KP_Subtract:
					this.In.text += " -";
					on_enter();
					return true;
				case Gdk.Key.KP_Divide:
					this.In.text += " /";
					on_enter();
					return true;
				case Gdk.Key.KP_Multiply:
					this.In.text += " *";
					on_enter();
					return true ;
			}
		
			if (this.In.is_focus) {	
			} else {
				this.In.has_focus = true;
			}
			return false;
            	});
		// connect some key callbacks

		this.myCalc = new rpn();
		// instantiate the calculator/interpreter
		
		if (filename != ""){
			this.preload(filename);
		}
		// preload a file if that is asked for

		hbox.pack_start(In,true,true,0);
		hbox.add(Enter);
		// add things to the hbox
	
		vbox.pack_start(Out,true,true,0);
		vbox.add(hbox);
		// add things to the vbox

		this.add(vbox);
		// add it all to this, our main window
	
	}


	public void run(){
/**
* run() method: Start Running
*  After the constructor has setup the graphical window, and declared the starting variables,
*  we display the window, connect the destroy signal, and set focus where it belongs.
**/
		this.show_all();
		this.destroy.connect(Gtk.main_quit);
                this.In.has_focus = true;
	}


	private void on_enter(){
/**
* on_enter() sends code to the calculator/interpreter and retrieves errors.
**/
		try {
			this.Out.buffer.text = myCalc.calc(this.In.buffer.text);
			this.In.set_text("");
		} catch (CalcError e){
			this.Out.buffer.text += "\nError: %s".printf(e.message);
			stderr.printf ("Error: %s\n", e.message);
		}
	}
}
