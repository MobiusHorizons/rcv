/****************************************
 * Reverse Polish Notation Calculator	*
 * Author: Paul Martin			*
 * Date: 				*
 ****************************************/

using Gtk;

public class Stack: Object{
	private double[] myArray;
	public Stack(){}
	public void push(double d){
		this.myArray.resize(myArray.length + 1);
		this.myArray[this.myArray.length-1] = d;
	}
	public double pop(){
		if (this.myArray.length > 0){
			double temp = this.myArray[this.myArray.length-1];
			this.myArray[this.myArray.length-1] = 0;
			this.myArray.resize(this.myArray.length-1);
			return temp;
		} else {
			return top();
		}
	}
	public double top(){
		return this.myArray[this.myArray.length-1];
	}
	public string to_string(int lines = -1){ // negative numbers for all lines.
			string line = "";
			if (lines > this.myArray.length){ lines = this.myArray.length - 1;}
			if (lines < 0){ lines = this.myArray.length - 1;}
			for (int i = lines ; i >= 0; i--){
				line += @"$(this.myArray[i])";
				if ( i != 0) line += "\n";
			}
			return line;
	}
			
} // end Stack class.





public class rpn: Object {
	private double[] reg;
	private Stack st;
	public rpn(int registers = 10){
		this.st = new Stack();
		this.reg = new double[registers];
	}
	public string calc(string input){
		string line = input + "\n"; // add terminating character.
		string temp = "";
		unichar c;
		for (int i = 0; line.get_next_char(ref i, out c);){
			if (c == '\n'){ //newline
				c = ' ';
			}
			if (c == ' ' || c == '\t'){ //whitespace
				switch (temp) {
					case "sw":
						// switch a, b
						double temp1 = this.st.pop();
						double temp2 = this.st.pop();
						this.st.push(temp1);
						this.st.push(temp2);
						break;
					case "sto": // x y sto 
						    // stores x in register y
						int rn = (int)this.st.pop();
						rn ++;
						if (rn > reg.length){
							reg.resize(rn);
							reg[0] = rn;
						}
						reg[rn]=this.st.pop();
						break;
					case "ret":
						int rn = (int)this.st.pop();
						rn ++;
						// error checking here;
						this.st.push(reg[rn]);
						break;
					case "clr":
						int rn = (int)this.st.pop();
						rn ++;
						// error checking here;
						reg[rn] = 0;
						break;
					case "drop": // drop item from stack
						this.st.pop();
						break;
					case "dropn": //drop n members from stack
						int n = (int)this.st.pop();
						for(i = 0; i < n; i++){
							this.st.pop();
						}
						break;
					case "+":
						double tmp = this.st.pop();
						tmp += this.st.pop();
						this.st.push(tmp);
						break;
					case "-":
						double tmp = this.st.pop();
						tmp = this.st.pop() - tmp;
						this.st.push(tmp);
						break;
					case "/":
						double tmp = this.st.pop();
						tmp = this.st.pop()/ tmp;
						this.st.push(tmp);
						break;
					case "*":
						double tmp = this.st.pop();
						tmp *= this.st.pop();
						this.st.push(tmp);
						break;
			
					default:
						if (temp != ""){
							double val = double.parse(temp);
							if ( val == 0.0){
								// regex check to see if it is a value
							}
							this.st.push(val);
						}
						break;
				} // end case statement
				temp = "";
			} else {
				temp += "%s".printf(c.to_string());
			}

		}
		return @"$st";
	}

}

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

int main (string[] args) {
	Gtk.init (ref args);
	var calcWin = new main_window();
	calcWin.destroy.connect(Gtk.main_quit);
	calcWin.show_all();
	Gtk.main();

	
	return 0;
}
