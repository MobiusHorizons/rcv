inline void println (string s){ stdout.printf("%s\n",s);}
inline bool getln (out string line){ 
		line = stdin.read_line();
	if ( !stdin.eof() && line != null){ 
		return true;
	} else {
		return false;
	}
}


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

public static int main (){
	var reg = new double[10]; // start with 10 registers
	var st = new Stack();
	string line= "";
	while (getln(out line)){
		line += "\n"; // add terminating character.
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
						double temp1 = st.pop();
						double temp2 = st.pop();
						st.push(temp1);
						st.push(temp2);
						break;
					case "sto": // x y sto 
						    // stores x in register y
						int rn = (int)st.pop();
						rn ++;
						if (rn > reg.length){
							reg.resize(rn);
							reg[0] = rn;
						}
						reg[rn]=st.pop();
						break;
					case "ret":
						int rn = (int)st.pop();
						rn ++;
						// error checking here;
						st.push(reg[rn]);
						break;
					case "clr":
						int rn = (int)st.pop();
						rn ++;
						// error checking here;
						reg[rn] = 0;
						break;
					case "drop": // drop item from stack
						st.pop();
						break;
					case "dropn": //drop n members from stack
						int n = (int)st.pop();
						for(i = 0; i < n; i++){
							st.pop();
						}
						break;
					case "+":
						double tmp = st.pop();
						tmp += st.pop();
						st.push(tmp);
						break;
					case "-":
						double tmp = st.pop();
						tmp = st.pop() - tmp;
						st.push(tmp);
						break;
					case "/":
						double tmp = st.pop();
						tmp = st.pop()/ tmp;
						st.push(tmp);
						break;
					case "*":
						double tmp = st.pop();
						tmp *= st.pop();
						st.push(tmp);
						break;
			
					default:
						//println(temp);
						if (temp != ""){
							double val = double.parse(temp);
							if ( val == 0.0){
								// regex check to see if it is a value
							}
							st.push(val);
							//iprintln(temp);
							//stdout.printf("value is %lf\n",val);
						}
						break;
				}
				temp = "";
			} else {
				temp += "%s".printf(c.to_string());
			}

		}
		//for (int i = 0; i < myArray.length; i++){
		//	println(@"$(myArray[i])");
		//}
		println(@"$(st)");
	}

	return 0;
}


