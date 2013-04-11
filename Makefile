
all: rpn rpnGtk


rpn: rpn.vala
	valac rpn.vala 
rpnGtk: window.vala stack.vala rpnCalc.vala main.vala
	valac --pkg gtk+-3.0 stack.vala rpnCalc.vala window.vala main.vala -o rpnGtk

clean:
	rm -f rpn rpnGtk 
