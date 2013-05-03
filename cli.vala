/********************************
 * File: cli.vala		*
 * Author: Paul Martin		*
 * Date: 05-02-13		*
 ********************************/

public class CLI: Object{
	private rpn myCalc;

	public CLI(string filename = ""){
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
		println("Paul's RPN calc in Vala"); // welcome screen
	}

	private inline void println (string s, FileStream str = stdout){ 
		str.printf("%s\n",s);
	} // wrapper stream.printf

	private inline bool getln (out string line, FileStream str = stdin){  // wrapper for geting a line from stream.
			line = str.read_line();
		if ( !str.eof() && line != null){ 
			return true;
		} else {
			return false;
		}
	}

	public void run(){
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
