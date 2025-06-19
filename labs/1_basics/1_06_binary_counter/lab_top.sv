`include "config.svh"

module lab_top
# (
    parameter  clk_mhz       = 50,
               w_key         = 4,
               w_sw          = 8,
               w_led         = 8,
               w_digit       = 8,
               w_gpio        = 100,

               screen_width  = 640,
               screen_height = 480,

               w_red         = 4,
               w_green       = 4,
               w_blue        = 4,

               w_x           = $clog2 ( screen_width  ),
               w_y           = $clog2 ( screen_height )
)
(
    input                        clk,
    input                        slow_clk,
    input                        rst,

    // Keys, switches, LEDs

    input        [w_key   - 1:0] key,
    input        [w_sw    - 1:0] sw,
    output logic [w_led   - 1:0] led,

    // A dynamic seven-segment display

    output logic [          7:0] abcdefgh,
    output logic [w_digit - 1:0] digit,

    // Graphics

    input        [w_x     - 1:0] x,
    input        [w_y     - 1:0] y,

    output logic [w_red   - 1:0] red,
    output logic [w_green - 1:0] green,
    output logic [w_blue  - 1:0] blue,

    // Microphone, sound output and UART

    input        [         23:0] mic,
    output       [         15:0] sound,

    input                        uart_rx,
    output                       uart_tx,

    // General-purpose Input/Output

    inout        [w_gpio  - 1:0] gpio
);

    //------------------------------------------------------------------------

    // assign led        = '0;
       assign abcdefgh   = '0;
       assign digit      = '0;
       assign red        = '0;
       assign green      = '0;
       assign blue       = '0;
       assign sound      = '0;
       assign uart_tx    = '1;

    //------------------------------------------------------------------------

    // Exercise 1: Free running counter.
    // How do you change the speed of LED blinking?
    // Try different bit slices to display.
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//                                               num1 
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 

//    localparam w_cnt = $clog2 (clk_mhz * 1000 * 1000*10); // 10 seconds over
//
//    logic [w_cnt - 1:0] cnt;
//
//    always_ff @ (posedge clk or posedge rst)
//        if (rst)
//            cnt <= '0;
//        else
//            cnt <= cnt + 1'd1;
//
//    assign led = cnt [$left (cnt)-1 -: w_led]; // 5 sec with (cnt)-1
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 

    // Exercise 2: Key-controlled counter.
    // Comment out the code above.
    // Uncomment and synthesize the code below.
    // Press the key to see the counter incrementing.
    //
    // Change the design, for example:
    //
    // 1. One key is used to increment, another to decrement.
    //
    // 2. Two counters controlled by different keys
    // displayed in different groups of LEDs.
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//                                               num2  
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 

//    logic crement;
//	 logic any_key;
//    logic any_key_r;
//	 always_comb begin 
//	   
//		crement = 0;
//		case(key)
//		
//		4'b0001: begin
//	     crement = 0;
//		  any_key = 1;
//		  end
//		4'b0010: begin
//	     crement = 1;
//		  any_key = 1;
//		  end
//		default:  any_key = 0;
//	 endcase
//   end
//	
//	
//    always_ff @ (posedge clk or posedge rst)
//        if (rst)
//            any_key_r <= '0;
//        else
//				
//            any_key_r <= |key;
//
//    wire any_key_pressed = any_key & ~any_key_r;
//
//    logic [w_led - 1:0] cnt;
//
//    always_ff @ (posedge clk or posedge rst)
//        if (rst)
//            cnt <= '0;
//        else if (any_key_pressed)
//            cnt <= crement? cnt + 1: cnt -1;
//
//    assign led = w_led' (cnt);
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//                                               num 3
  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 

    logic in_or_decrement;
	 logic left_or_right;
	 logic any_key;
    logic any_key_r;

	 always_comb begin 
	   
		in_or_decrement = 0;
		left_or_right = 0;
		case(key)
		
		4'b0001: begin
	     in_or_decrement = 0;
		  any_key = 1;
		  left_or_right=0;
		  end
		4'b0010: begin
	     in_or_decrement = 1;
		  any_key = 1;
		  left_or_right=0;
		  end
		4'b0100: begin
	     in_or_decrement = 0;
		  any_key = 1;
		  left_or_right=1;
		  end
		4'b1000: begin
	     in_or_decrement = 1;
		  any_key = 1;
		  left_or_right=1;
		  end
		default:  any_key = 0;
	 endcase
   end
	
	
    always_ff @ (posedge clk or posedge rst)
        if (rst)
            any_key_r <= '0;
        else
				
            any_key_r <= |key;

    wire any_key_pressed = any_key & ~any_key_r;

    logic [w_led/2-1 :0] cntleft;
	 logic [w_led/2-1 :0] cntright;

    always_ff @ (posedge clk or posedge rst)
        if (rst) begin
            cntleft <= '0;
				cntright <= '0;
				end
        else if (any_key_pressed) begin
            cntleft <= (in_or_decrement? cntleft + (1& !left_or_right): cntleft +(-1 & !left_or_right));
				cntright <= (in_or_decrement? cntright +(1& left_or_right): cntright +(-1& left_or_right));
		  end
    assign led = w_led'({cntright, cntleft});
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  // 
  

endmodule
