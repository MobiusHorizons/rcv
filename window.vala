using Gtk;

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

		this.In = new Entry();
		this.Enter = new Button.with_label("Enter");

		var hbox = new Box (Orientation.HORIZONTAL,2);
		var vbox = new Box (Orientation.VERTICAL,2);

		this.Enter.clicked.connect(on_enter);
		this.In.activate.connect(on_enter);
		
		this.myCalc = new rpn();

		hbox.pack_start(In,true,true,0);
		hbox.add(Enter);
	
		vbox.pack_start(Out,true,true,0);
		vbox.add(hbox);
		this.add(vbox);
	
	}
	private void on_enter(){
		this.Out.buffer.text = myCalc.calc(this.In.buffer.text);
		this.In.set_text("");
	}
}
