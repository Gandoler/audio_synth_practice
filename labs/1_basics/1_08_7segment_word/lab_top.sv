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
    // assign abcdefgh   = '0;
    // assign digit      = '0;
       assign red        = '0;
       assign green      = '0;
       assign blue       = '0;
       assign sound      = '0;
       assign uart_tx    = '1;

    //------------------------------------------------------------------------

    logic [31:0] cnt;

    always_ff @ (posedge clk or posedge rst)
        if (rst)
            cnt <= '0;
        else
            cnt <= cnt + 1'd1;


    //------------------------------------------------------------------------

    logic [w_digit:0] shift_reg;
    
    always_ff @ (posedge clk or posedge rst)
      if (rst)
        shift_reg <= w_digit' (1);
      else if (enable)
        shift_reg <= { shift_reg [0], shift_reg [w_digit - 1:1] };


    //------------------------------------------------------------------------

    //   --a--
    //  |     |
    //  f     b
    //  |     |
    //   --g--
    //  |     |
    //  e     c
    //  |     |
    //   --d--  h

    typedef enum bit [7:0]
    {
        F     = 8'b1000_1110,
        P     = 8'b1100_1110,
        G     = 8'b1011_1100,
        A     = 8'b1110_1110,
		  L     = 8'b0001_1100,
		  E     = 8'b1001_1110,
		  B     = 8'b0011_1110,
        space = 8'b0000_0000
    }
    seven_seg_encoding_e;

   

   


    // Exercise 1: Increase the frequency of enable signal
    // to the level your eyes see the letters as a solid word
    // without any blinking. What is the threshold of such frequency?
	 
	 
	 
//     wire enable = (cnt [16:0] == '0); // Просто изменяем до какого бита мы считаем; было 22
    
	  
//	   seven_seg_encoding_e letter;
//	   always_comb
//      case (4' (shift_reg))
//      4'b1000: letter = F;
//      4'b0100: letter = P;
//      4'b0010: letter = G;
//      4'b0001: letter = A;
//      default: letter = space;
//      endcase
////	  
	  
    // Exercise 2: Put your name or another word to the display.

	  wire enable = (cnt [16:0] == '0);
	  
	 seven_seg_encoding_e letter;
	   always_comb
      case (4' (shift_reg))
      4'b1000: letter = G;
      4'b0100: letter = L;
      4'b0010: letter = E;
      4'b0001: letter = B;
      default: letter = space;
      endcase
	 
    // Exercise 3: Comment out the "default" clause from the "case" statement
    // in the "always" block,and re-synthesize the example.
    // Are you getting any warnings or errors? Try to explain why.

//	 
//	  wire enable = (cnt [16:0] == '0);
//	  
//	 seven_seg_encoding_e letter;
//	   always_comb
//      case (4' (shift_reg))
//      4'b1000: letter = G;
//      4'b0100: letter = L;
//      4'b0010: letter = E;
//      4'b0001: letter = B;
//      default: letter = space;
//      endcase


//Error (10166): SystemVerilog RTL Coding error at lab_top.sv(166): always_comb construct does not infer purely combinational logic.
// пока обьяснить не могу
	 
	 // вывод: 
	 assign abcdefgh = letter;
    assign digit    = shift_reg;
	 assign led = w_led' (shift_reg);
endmodule
