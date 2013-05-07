
all: rpn


rpn: window.vala stack.vala rpnCalc.vala main.vala cli.vala
	valac --pkg posix --pkg gtk+-3.0 stack.vala -X -lm rpnCalc.vala window.vala main.vala cli.vala -o rpn

clean:
	rm -f rpn *~ 
