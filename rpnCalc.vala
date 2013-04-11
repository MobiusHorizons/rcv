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
