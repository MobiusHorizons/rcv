
public class CLI: Object{
	private rpn myCalc;

	public CLI(){
		this.myCalc = new rpn();
	}

	private inline void println (string s, FileStream str = stdout){ str.printf("%s\n",s);}
	private inline bool getln (out string line, FileStream str = stdin){ 
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
			println(myCalc.calc(line));
		}
	}

}

