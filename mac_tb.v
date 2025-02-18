// inputs are read from a text file containing a list of 64 binary numbers

module tb();
reg clk,en;
//reg signed [31:0] mem [63:0];
reg signed [15:0] xn_re,xn_im,xn4_re,xn4_im;
wire signed [31:0] yn_re,yn_im;
wire [5:0] counter;
wire signed [31:0] summer_a,summer_b;
wire  signed [31:0] re,im;


    initial begin
        clk=0;
        forever #5 clk = !clk;
    end
    
integer f1 ;
integer i;
reg [15:0] numbers1 [63:0];
reg [15:0] numbers2 [63:0];
//reg [15:0] numbers3 [63:0];
//reg [15:0] numbers4 [63:0];

mac m0(clk,en,xn_re,xn_im,xn4_re,xn4_im,yn_re,yn_im, counter,summer_a,summer_b,re,im);

initial
begin
// Creates a file 'my_inv.txt' in the same folder
f1 = $fopen("mac.txt", "w");
// The first line with Literals A B
$fdisplay(f1,"yn_re"," ", "yn_im");
$readmemb("input_numbers_binary.txt", numbers1);
$readmemb("input_numbers_binary2.txt", numbers2);

//$readmemb("input_numbers_binary3.txt", numbers3);
//$readmemb("input_numbers_binary4.txt", numbers4);
en = 0;
#10; en = 1;
// Wrtie A and B into output file my_inv.txt
$fmonitor(f1,"%b %b",yn_re, yn_im);
// G:\Xilinx_projects\EE560\EE560.sim\sim_1\behav
// The output file is in this location.
// EE560 is the project name

// Keep reading lines until EOF is found
for(i = 0; i<= 59;i = i + 1)
begin
xn_re = numbers1[i];
xn_im = numbers2[i];
xn4_re = numbers1[i+4];
xn4_im = numbers2[i+4];
//en = !en;
#12;
// Display contents of the variable
end
$fclose(f1);
end
endmodule   
