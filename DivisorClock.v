// Definição do módulo DivisorClock
module DivisorClock (
 input clock,
 output slow_clk,
 output medium_clk,
 output fast_clk
);

 // Fios intermediários
 wire [25:0] Q;

 fft div_2 (.T(1'b1), .clock(clock), .Q(Q[0]));
 fft div_4 (.T(1'b1), .clock(Q[0]), .Q(Q[1]));
 fft div_8 (.T(1'b1), .clock(Q[1]), .Q(Q[2]));
 fft div_16 (.T(1'b1), .clock(Q[2]), .Q(Q[3]));    
 fft div_32 (.T(1'b1), .clock(Q[3]), .Q(Q[4]));
 fft div_64 (.T(1'b1), .clock(Q[4]), .Q(Q[5]));
 fft div_128 (.T(1'b1), .clock(Q[5]), .Q(Q[6]));
 fft div_256 (.T(1'b1), .clock(Q[6]), .Q(Q[7]));
 fft div_512 (.T(1'b1), .clock(Q[7]), .Q(Q[8]));
 fft div_1024 (.T(1'b1), .clock(Q[8]), .Q(Q[9]));
 fft div_2048 (.T(1'b1), .clock(Q[9]), .Q(Q[10]));
 fft div_4096 (.T(1'b1), .clock(Q[10]), .Q(Q[11]));
 fft div_8192 (.T(1'b1), .clock(Q[11]), .Q(Q[12]));
 fft div_16384 (.T(1'b1), .clock(Q[12]), .Q(Q[13]));
 fft div_32768 (.T(1'b1), .clock(Q[13]), .Q(Q[14]));
 fft div_65536 (.T(1'b1), .clock(Q[14]), .Q(Q[15]));
 fft div_131072 (.T(1'b1), .clock(Q[15]), .Q(Q[16]));
 fft div_262144 (.T(1'b1), .clock(Q[16]), .Q(Q[17]));
 fft div_524288 (.T(1'b1), .clock(Q[17]), .Q(Q[18]));
 fft div_1048576 (.T(1'b1), .clock(Q[18]), .Q(Q[19]));
 fft div_2097152 (.T(1'b1), .clock(Q[19]), .Q(Q[20]));
 fft div_4194304 (.T(1'b1), .clock(Q[20]), .Q(Q[21]));
 fft div_8388608 (.T(1'b1), .clock(Q[21]), .Q(Q[22]));
 fft div_24 (.T(1'b1), .clock(Q[22]), .Q(Q[23]));
 fft div_25 (.T(1'b1), .clock(Q[23]), .Q(Q[24]));
 fft div_26 (.T(1'b1), .clock(Q[24]), .Q(Q[25]));

 assign slow_clk = Q[25];
 assign medium_clk = Q[24];
 assign fast_clk = Q[23];
 
endmodule 