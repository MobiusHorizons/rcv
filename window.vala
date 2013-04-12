using Gtk;
using GLib;

public class main_window: Window {
	private Gtk.TextView Out;
	private Gtk.Entry In;
	private Gtk.Button Enter;
	private rpn myCalc;

	public main_window(){
		this.title = "Rpn Calculator";
		this.border_width = 10;
		this.window_position=WindowPosition.CENTER;
		this.set_default_size(500,400);


		this.Out = new TextView();
		this.Out.editable=false;
		this.Out.can_focus=false;

		this.In = new Entry();

		this.Enter = new Button.with_label("Enter");

		var hbox = new Box (Orientation.HORIZONTAL,2);
		var vbox = new Box (Orientation.VERTICAL,2);

		this.Enter.clicked.connect(on_enter);
		this.In.activate.connect(on_enter);
		
		this.key_press_event.connect ((e) => {
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
		this.myCalc = new rpn();

		hbox.pack_start(In,true,true,0);
		hbox.add(Enter);
	
		vbox.pack_start(Out,true,true,0);
		vbox.add(hbox);
		this.add(vbox);
	
	}
	public void run(){
		this.show_all();
		this.destroy.connect(Gtk.main_quit);
                this.In.has_focus = true;
	}

	private void on_enter(){
		try {
			this.Out.buffer.text = myCalc.calc(this.In.buffer.text);
			this.In.set_text("");
		} catch (CalcError e){
			this.Out.buffer.text += "\nError: %s".printf(e.message);
			stderr.printf ("Error: %s\n", e.message);
		}
	}
}
