// Top level module
// extra unnecessary variables in output for debugging purposes

module mac(input clk,en,input [15:0] xn_re,xn_im,xn4_re,xn4_im,output reg signed [31:0] yn_re,yn_im, output reg [5:0] counter, output reg signed [31:0] summer_a,summer_b,output reg  signed [31:0] re,im);

//reg [5:0] counter = 0;
//reg signed [37:0] summer_a,summer_b = 0;
//reg  signed [31:0] re,im = 0;
reg  signed [31:0]temp[3:0];
reg  signed [15:0]input_reg[3:0];
//reg signed [31:0] mem [63:0];
 
    always @ (posedge clk)
        begin
            if (en) begin
                if (counter==6'd63) begin
                
                        yn_re <= summer_a >>> 6;  // divide by 2^6
                        yn_im <= summer_b >>> 6 ; // divide by 2^6
                        counter  <= 0;
                        summer_a <= 0;
                        summer_b <= 0;
                        
                    end else begin
                     
                    input_reg[0]<=xn_re;
                    input_reg[1]<=xn_im;
                    input_reg[2]<=xn4_re;
                    input_reg[3]<=xn4_im;
 
 
                    temp[0] <= input_reg[0]*input_reg[2];
                    temp[1] <= input_reg[1]*input_reg[3];
                    temp[2] <= input_reg[1]*input_reg[2];
                      temp[3] <= input_reg[0]*input_reg[3];            //Multiply operation
                      re <= temp[0] + (~temp[1] + 1);                 // real part
                      im <= temp[2] + temp[3];                          //imaginary part
                    
                    summer_a <= summer_a + re;   // summing real numbers
                    summer_b <= summer_b + im;   // summing imaginary numbers
                    counter <= counter + 1;      // updating memory address count
                    
                    end

              end else begin
                    counter <= 0;
                    yn_re <= 0;
                    yn_im <= 0;
                     input_reg[0]<=0;  
                     input_reg[1]<=0;  
                     input_reg[2]<=0; 
                     input_reg[3]<=0;
                    temp[0] <= 0;
                    temp[1] <= 0;
                    temp[2] <= 0;
                    temp[3] <= 0;
                    im<=0;
                    re<=0;
                    summer_a <= 0;
                    summer_b <= 0;                      // initialising registers
                      
              end
        end

endmodule
