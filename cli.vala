/****************************************
 * Reverse Polish Notation Calculator	*
 * File: cli.vala			*
 * Author: Paul Martin			*
 * Date: 05-02-13			*
 ****************************************/

public class CLI: Object{
/**
 * The Command Line object
 * has it's own instance of calculator, and handles IO
**/
	private rpn myCalc;

	public CLI(string filename = ""){
/**
 * CLI Constructor:
 * 
 * instantiates the class variable rpn
 * and loads the commands from the file if specified
**/
		this.myCalc = new rpn();
		if (filename != ""){		// pull in startup file
			var file = FileStream.open(filename, "r"); 
			string line = "";
			int i = 0;
			while(getln(out line, file)){ // read from file
				i++;
				try {
					this.myCalc.calc(line); // execute file
				} catch (CalcError e){
					stderr.printf("Error: in %s, on line %d, %s", filename,i,e.message); // output errors
				}
			}
		}
		println("Paul's RPN calc in Vala\nCtrl-D to exit"); // welcome screen
	}

	private inline void println (string s, FileStream str = stdout){ 
/**
 * void println(): prints a string to a stream
 * 
 * default stream is stdout
**/
		str.printf("%s\n",s);
	} 

	private inline bool getln (out string line, FileStream str = stdin){  // wrapper for geting a line from stream.
/**
 * bool getln(): retrieve a line from a stream;
 *
 *  * default stream is stdin
 *  * returns false at eof
**/
			line = str.read_line();
		if ( !str.eof() && line != null){ 
			return true;
		} else {
			return false;
		}
	}

	public void run(){
/**
 * void run(): start running
 * 
 * Read Eval Print with error detection
**/
		string line = "";
		while(getln (out line)){
			try {
				println("");
				println(myCalc.calc(line));
				println("----------------------");
			} catch (CalcError e){
				stderr.printf("Error: %s\n", e.message);
			}
		}
	}

}
