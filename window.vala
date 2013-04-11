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
		
		this.key_press_event.connect ((e) => {
		if (!this.In.is_focus){
		        switch (e.keyval) {
		        	case Gdk.Key.KP_Add:
		        	        this.In.text += " +";
					on_enter();
		        	        break;
				case Gdk.Key.KP_Subtract:
					this.In.text += " -";
					on_enter();
					break;
				case Gdk.Key.KP_Divide:
					this.In.text += " /";
					on_enter();
					break;
				case Gdk.Key.KP_Multiply:
					this.In.text += " *";
					on_enter();
					break;
				case Gdk.Key.KP_Enter:
					on_enter();
					break;
				case Gdk.Key.KP_Decimal:
					this.In.text += ".";
					break;
				case Gdk.Key.KP_0:
					this.In.text += "0";
					break;
				case Gdk.Key.KP_1:
					this.In.text += "1";
					break;
				case Gdk.Key.KP_2:
					this.In.text += "2";
					break;
				case Gdk.Key.KP_3:
					this.In.text += "3";
					break;
				case Gdk.Key.KP_4:
					this.In.text += "4";
					break;
				case Gdk.Key.KP_5:
					this.In.text += "5";
					break;
				case Gdk.Key.KP_6:
					this.In.text += "6";
					break;
				case Gdk.Key.KP_7:
					this.In.text += "7";
					break;
				case Gdk.Key.KP_8:
					this.In.text += "8";
					break;
				case Gdk.Key.KP_9:
					this.In.text += "9";
					break;
			
		        }
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
	private void on_enter(){
		this.Out.buffer.text = myCalc.calc(this.In.buffer.text);
		this.In.set_text("");
	}
}
