public errordomain CalcError{
	STACK_UNDERRUN,
	PARSE_ERROR,
	REGISTER_ERROR
}
public class rpn: Object {
	private double[] reg;
	private Stack st;
	private HashTable<string,string> userFunc;
	public rpn(int registers = 10){
		this.st = new Stack();
		this.reg = new double[registers];
		this.userFunc = new HashTable<string,string> (str_hash, str_equal);
	}
	private void require(string op, int n) throws CalcError{
		string s = "s";
		if (!st.has(n)) {
			if (n == 1){ s = "" ;}
			throw new CalcError.STACK_UNDERRUN("%s requires at least %d element%s in the stack".printf(op,n,s));
		}
	}
	public string calc(string input) throws CalcError{
		string line = input + "\n"; // add terminating character.
		string temp = "";
		unichar c;
		for (int i = 0; line.get_next_char(ref i, out c);){
			if (c == '\n'){ //newline
				c = (unichar)' ';
			}
			if (c == ' ' || c == '\t'){ //whitespace
				switch (temp) {
					case "define":
						// user defined function
						string[] parts = input.slice(i, input.length).split(" ",2); // 
						if (parts.length == 2){ // make sure we have a function name and a body.
							this.userFunc.insert(parts[0],parts[1]); // add it to the hash
						}
						i += parts[0].length;
						break;
					case "sw":
						// switch a, b
						this.require("Switch", 2); 
						double temp1 = this.st.pop();
						double temp2 = this.st.pop();
						this.st.push(temp1);
						this.st.push(temp2);
						break;
					case "sto": // x y sto 
						    // stores x in register y
						this.require("Store", 2);
						int rn = (int)this.st.pop();
						rn ++;
						if (rn > reg.length){
							reg.resize(rn);
							reg[0] = rn;
						}
						reg[rn]=this.st.pop();
						break;
					case "ret":
						this.require("Return", 1);
						int rn = (int)this.st.pop();
						rn ++;
						// error checking here;
						this.st.push(reg[rn]);
						break;
					case "clr":
						this.require("Clear Register", 1);
						int rn = (int)this.st.pop();
						rn ++;
						// error checking here;
						reg[rn] = 0;
						break;
					case "drop": // drop item from stack
						this.require("Drop", 1);
						this.st.pop();
						break;
					case "dropn": //drop n members from stack
						this.require("Drop n", 1);
						int n = (int)this.st.pop();
						this.require(@"Drop $n",n);
						for(i = 0; i < n; i++){
							this.st.pop();
						}
						break;
					case "+":
						this.require("Addition", 2);
						double tmp = this.st.pop();
						tmp += this.st.pop();
						this.st.push(tmp);
						break;
					case "-":
						this.require("Subtraction",2);
						double tmp = this.st.pop();
						tmp = this.st.pop() - tmp;
						this.st.push(tmp);
						break;
					case "/":
						this.require("Division",2);
						double tmp = this.st.pop();
						tmp = this.st.pop()/ tmp;
						this.st.push(tmp);
						break;
					case "*":
						this.require("Multiplication",2);
						double tmp = this.st.pop();
						tmp *= this.st.pop();
						this.st.push(tmp);
						break;
			
					default:
						if (temp != ""){
							var f = this.userFunc.get(temp);
							if (f != null){
								this.calc(f);
							} else {
								double val = double.parse(temp);
								if ( val == 0.0){
									// regex check to see if it is a value
								}
								this.st.push(val);
							}
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
