`timescale 1ns/1ns // specify what "#1" means!

/* Observations in view of the project:
	Signals:
		Ready - rdy - it's only "1" when we find the gcd and "0" while processing it
		Reset - rst - it's "0" while processing the inputs, when the testbench send rst = "1", it's to start to analyse the gcd
*/

module gcd (xi, yi, rst, xo, rdy, clk);

  input [15:0] xi, yi;
  input rst, clk;

  output reg [15:0] xo;
  output reg rdy = 1'b0;
  reg [15:0] x, y;


  always @(posedge clk)
  begin
  	if (rst == 1'b0)   
	begin
        	x <= xi;
        	y <= yi;
		rdy <= 0;
      	end 
    	else 
	begin	
		if( x != 0 && y != 0) 
		begin		
        		if (x != y)
			begin
				//for while i need to use blocking (??)
          			if (y > x)  			begin y <= y - x; end //$display("aqui1: %d e %d",x,y);end//if y greater than x, we need to get a smaller y by y-x
				else if (x > y) 		begin x <= x - y; end //$display("here: %d e %d",x,y);end //same here

			end
			else if (x==y)
			begin
        			xo <= x; //Can be xo <= y;
        			rdy <= 1'b1;
			end
		end
		else 
		begin
			xo <= 0; //Can be xo <= y;
        		rdy <= 1'b1;
		end
	end

    end

endmodule