`timescale 1ns/1ns // specify what "#1" means!

/* Observations in view of the project:
	Signals:
		Ready - rdy - it's only "1" when we find the gcd and "0" while processing it
		Reset - rst - it's "0" while processing the inputs, when the testbench send rst = "1", it's to start to analyse the gcd
*/

module gcd_behavioural (xi, yi, rst, xo, rdy, clk);

  input [15:0] xi, yi;
  input rst, clk;

  output reg [15:0] xo;
  output reg rdy = 1'b0;
  reg [15:0] x, y;


  always @(posedge clk)
  begin
	  if (rst == 1'b0)   // Can be a while with a delay
	begin
        	x <= xi;
        	y <= yi;
		rdy <= 0;
      	end 

    	else 
	begin	
		if( x != 0 && y != 0) 
		begin		
        		while (x != y) // will perform all in the same clk cycle - so its needed to add a delay
			begin
				//for while i need to use blocking, only if I not use a delay!!
          			if (y > x)  		y = y - x;  
				else if (x > y) 	x = x - y; 
				
				@(posedge clk); //#10; - It's the same

			end
        		xo <= x; //Can be xo <= y;
        		rdy <= 1'b1;
		end
		else 
		begin
			xo <= 0; 
        		rdy <= 1'b1;
		end
	end

    end

endmodule
