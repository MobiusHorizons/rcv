/****************************************
 * Reverse Polish Notation Calculator	*
 * Author: Paul Martin			*
 * Date: 				*
 ****************************************/

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

