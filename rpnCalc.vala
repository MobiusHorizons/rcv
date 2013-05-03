/********************************
 * File: rpnCalc.vala		*
 * Author: Paul Martin		*
 * Date: 03-28-12		*
 ********************************/

public errordomain CalcError{
	STACK_UNDERRUN,
	PARSE_ERROR,
	REGISTER_ERROR
}

public class rpn: Object {
	private double[] reg;  	// register for intermediate storage
	private Stack st;	// main stack
	private HashTable<string,string> userFunc;	// used for storing user functions
	public rpn(int registers = 10){			// 
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
				c = (unichar)' '; //make sure the last argument is parsed correctly
			}
			if (c == ' ' || c == '\t'){ //whitespace
				switch (temp) {
					case "define":
						// user defined function
						string[] parts = input.slice(i, input.length).split(" ",2); // split into function name and body 
						if (parts.length == 2){ // make sure we have a function name and a body.
							this.userFunc.insert(parts[0],parts[1]); // add it to the hash
						}
						i += parts[0].length; // skip the function name, but run the body
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
						var n = this.st.pop();
						this.require(@"Drop $n",(int)n);
						for(int count = 0; count < n; count++){
							this.st.pop();
						}
						break;
					case "+": // adition
						this.require("Addition", 2);
						double tmp = this.st.pop();
						tmp += this.st.pop();
						this.st.push(tmp);
						break;
					case "-": // subtraction
						this.require("Subtraction",2);
						double tmp = this.st.pop();
						tmp = this.st.pop() - tmp;
						this.st.push(tmp);
						break;
					case "/": //division
						this.require("Division",2);
						double tmp = this.st.pop();
						tmp = this.st.pop()/ tmp;
						this.st.push(tmp);
						break;
					case "*": //multiplication
						this.require("Multiplication",2);
						double tmp = this.st.pop();
						tmp *= this.st.pop();
						this.st.push(tmp);
						break;
			
					default:
						if (temp != ""){
							var f = this.userFunc.get(temp);// try to get a user defined function
							if (f != null){ 		// if there was one
								this.calc(f); 		// execute it recursively
							} else { 			// otherwise
								double val;
								if (double.try_parse(temp, out val)){ 	// if it is a number
									this.st.push(val);   		// push it to the stack
								} else {				// else throw an error
									throw new CalcError.PARSE_ERROR("%s is not a known function or number".printf(temp));
								}
							}
						}
						break;
				} // end case statement
				temp = "";
			} else { // append c to string
				temp += "%s".printf(c.to_string());
			}

		}
		return @"$st";
	}

}
