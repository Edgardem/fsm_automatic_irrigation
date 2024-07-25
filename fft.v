// Declaracao do modulo do flip-flop T
module fft (T, clock, Q);

	// Declaracao de portas
	input T;
   input clock;
   output reg Q;

   // Inicialização dos estados de Q e Qb
   initial begin
       Q = 0;
   end

   always @(posedge clock) begin
	
      if (T) begin
			Q <= ~Q;
      end
   end

endmodule 