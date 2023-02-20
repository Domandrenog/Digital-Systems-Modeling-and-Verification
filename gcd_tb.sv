`timescale 1ns/1ns
// specify what "#1" means!

/* 
Types of tests:
	Prime Numbers - the result is gonna be = 1
	Equal Numbers - the result is gonna be the number
	One be 0 - the result will be 0
	X be greater than Y
	Y be greater than X
	Random Numbers
*/

module gcd_tb;

  // Parameters
  parameter CLK_PERIOD = 10;
  parameter CICLES = 100;

  // Inputs
  reg [15:0] xi, yi;
  reg rst, clk;

  // Outputs
  wire [15:0] xo;
  wire [15:0] xo2;
  wire rdy;

  integer totalerrorsbeh = 0;
  integer totalerrorsrtl = 0;
  integer i;
  reg [15:0] a;
  reg [15:0] b;
  reg [15:0] expected;
  integer totalerrorsrandombeh = 0;
  integer totalerrorsrandomrtl = 0;


  // Instantiate the Unit Under Test (UUT)
  gcd beh (
    .xi(xi),
    .yi(yi),
    .rst(rst),
    .xo(xo),
    .rdy(rdy),
    .clk(clk)
  );

  // Instantiate the Unit Under Test (UUT)
  gcd rtl (
    .xi(xi),
    .yi(yi),
    .rst(rst),
    .xo(xo2),
    .rdy(rdy),
    .clk(clk)
  );

  	initial //Testing possible errors
	begin
    
   		// Test case 1: Calculate GCD of prime numbers
       		$display("Test case: Calculate GCD of Prime Numbers");
		procedure(13,7);
      		//$display("  GCD(%d, %d) = %d", xi, yi, xo);
      		if (xo == 1) $display("  Prime Numbers - Test case passed - Behavioral");
      		else begin $display("  Prime Numbers - Test case failed: Expected 1, got %d - Behavioral", xo); totalerrorsbeh = totalerrorsbeh +1; end
		if (xo2 == 1) $display("  Prime Numbers - Test case passed - RTL");
      		else begin $display("  Prime Numbers - Test case failed: Expected 1, got %d - RTL", xo2); totalerrorsrtl = totalerrorsrtl +1; end
    

    		// Test case 2: Calculate GCD of  Equal Numbers - 65535 and 65535
    		$display("Test case 2: Calculate GCD of Equal Numbers");
    		procedure(65535,65535);
      		//$display("  GCD(%d, %d) = %d", xi, yi, xo);
      		if (xo == 16'hFFFF) $display("Equal Numbers - Test case passed - Behavioral");
      		else begin $display(" Equal Numbers - Test case failed: Expected %d, got %d - Behavioral", 16'hFFFF, xo); totalerrorsbeh = totalerrorsbeh +1; end
      		if (xo2 == 16'hFFFF) $display("Equal Numbers - Test case passed - RTL");
      		else begin $display(" Equal Numbers - Test case failed: Expected %d, got %d - RTL", 16'hFFFF, xo2); totalerrorsrtl = totalerrorsrtl +1; end


		// Test case 3: Calculate GCD of 0 numbers
    		$display("Test case: Calculate GCD of 0 Numbers");
		procedure(0,7);
      		//$display("  GCD(%d, %d) = %d", xi, yi, xo);
      		if (xo == 0) $display(" 0 Numbers - Test case passed - Behavioral");
      		else begin $display(" 0 Numbers - Test case failed: Expected 0, got %d - Behavioral", xo); totalerrorsbeh = totalerrorsbeh +1; end
      		if (xo2 == 0) $display(" 0 Numbers - Test case passed - RTL");
      		else begin $display(" 0 Numbers - Test case failed: Expected 0, got %d - RTL", xo2); totalerrorsrtl = totalerrorsrtl +1; end
      
	
		// Test case 4: Calculate GCD of X > Y - 42 and 18
    		$display("Test case: Calculate GCD of X > Y");
    		procedure(42,18);
      		//$display("  GCD(%d, %d) = %d", xi, yi, xo);
      		if (xo == 16'h6) $display("X > Y - Test case passed - Behavioral");
      		else begin $display(" X > Y - Test case failed: Expected %d, got %d - Behavioral", 16'h6, xo); totalerrorsbeh = totalerrorsbeh +1; end
      		if (xo2 == 16'h6) $display("X > Y - Test case passed - RTL");
      		else begin $display(" X > Y - Test case failed: Expected %d, got %d - RTL", 16'h6, xo2); totalerrorsrtl = totalerrorsrtl +1; end
    

		// Test case 5: Calculate GCD of Y > X - 42 and 18
    		$display("Test case 2: Calculate GCD of X > Y");
       		procedure(18,42);
      		//$display("  GCD(%d, %d) = %d", xi, yi, xo);
      		if (xo == 16'h6) $display("Y > X - Test case passed - Behavioral");
      		else begin $display(" Y > X - Test case failed: Expected %d, got %d - Behavioral", 16'h6, xo); totalerrorsbeh = totalerrorsbeh +1; end
      		if (xo2 == 16'h6) $display("Y > X - Test case passed - RTL");
      		else begin $display(" Y > X - Test case failed: Expected %d, got %d - RTL", 16'h6, xo2); totalerrorsrtl = totalerrorsrtl +1; end
    	


    		// Test case 6: Calculate GCD of Random Numbers

		repeat (CICLES) 
    		begin
      			// Generate random input values
      			a = $random;
      			b = $random;
			expected = 1;
      		
			procedure(a, b);

      			// Calculate the expected result
      			
      			for (i = 2; i <= a && i <= b; i++) 
			begin
        			if (a % i == 0 && b % i == 0) expected = i; //	Increase i between 2 and the max number between a and b and see when the rest of the both numbers are 0
        		end

      			// Check the result
      			if (xo != expected) 
			begin
        			$display("Error: gcd(%d, %d) = %d, expected %d", xi, yi, xo, expected);
        			totalerrorsbeh = totalerrorsbeh + 1;
				totalerrorsrandombeh = totalerrorsrandombeh + 1;
      			end

      			// Check the result
      			if (xo2 != expected) 
			begin
        			$display("Error: gcd(%d, %d) = %d, expected %d", xi, yi, xo2, expected);
        			totalerrorsrtl = totalerrorsrtl + 1;
				totalerrorsrandomrtl = totalerrorsrandomrtl + 1;
      			end
		
    		end

    if (totalerrorsrandombeh != 0) $display("Number of Errors Random: %d - Behavioral", totalerrorsrandombeh);
    else $display("All tests of Numbers Random passed! - Behavioral");

    if (totalerrorsrandomrtl != 0) $display("Number of Errors Random: %d - RTL", totalerrorsrandomrtl);
    else $display("All tests of Numbers Random passed! - RTL");

    if (totalerrorsbeh != 0) $display("Number of Errors: %d - Behavioral", totalerrorsbeh);
    else $display("All tests passed! - Behavioral");

    if (totalerrorsrtl != 0) $display("Number of Errors: %d - RTL", totalerrorsrtl);
    else $display("All tests passed! - RTL");
    
// Stop the simulation
    $stop;
 end


initial
begin
clk = 1'b0;
forever
    # (CLK_PERIOD / 2 ) clk = ~clk;
end


task procedure;
input [15:0] x,y;
begin
	xi = x;
    	yi = y; 
	rst = 1'b0;

    	// Wait for a few clock cycles
    	# (CLK_PERIOD * 5) rst = 1'b1;
	
	@(posedge rdy);

end
endtask

endmodule
