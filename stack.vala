/****************************************
 * Reverse Polish Notation Calculator	*
 * File: stack.vala			*
 * Description: Defines a stack data 	*
 *	structure for the calculator    *
 * Author: Paul Martin			*
 * Date:   03-18-13			*
 ****************************************/

public class Stack: Object{
/**
 * Stack object:
**/
	private double[] myArray;

	public Stack(){}
	// empty constructor

	public void push(double d){
/** 
 * void Stack.push():
 * 
 * push a double on to the stack
**/

		this.myArray.resize(myArray.length + 1);
		this.myArray[this.myArray.length-1] = d;
	}

	public double pop(){
/**
 * double Stack.pop():
 * 
 * pop a double off of the stack
**/
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
/** 
 * double Stack.top():
 *
 * look at the top item
**/
		return this.myArray[this.myArray.length-1];
	}

	public string to_string(int lines = -1){ // negative numbers for all lines.
/** 
 * string Stack.to_string():
 * output contents of stack as string
 * lines says how many lines to display
 * -1 displays all lines.
**/
			string line = "";
			if (lines > this.myArray.length){ lines = this.myArray.length - 1;}
			if (lines < 0){ lines = this.myArray.length - 1;}
			for (int i = lines ; i >= 0; i--){
				line += @"$(this.myArray[i])";
				if ( i != 0) line += "\n";
			}
			return line;
	}

	public bool has(int n){ 
/**
 * bool Stack.has():
 *
 * function for asking the stack if it has a certain number of elements
**/
		return n <= this.myArray.length;
	}
			
} // end Stack class.

