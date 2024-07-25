module ControleFrequencia (
    input fast_clk,
    input slow_clk,
	 input medium_clk,
    input start_fill,
    input Aspersao,
    input Gotejamento,
    input Limpeza,
    input ERRO,
	 input state,
    output reg Ctrl_clk
);

    wire Fast_on, Medium_on, Slow_on;

    assign Fast_on = (fast_clk && start_fill && state) || (fast_clk && Aspersao);
    assign Medium_on = (medium_clk && Gotejamento);
	assign Slow_on = (slow_clk && Limpeza);

    // Seletor de clock
    always @(*) begin
        if ((start_fill && state) || Aspersao) begin
            Ctrl_clk = Fast_on;
        end else if (Gotejamento) begin
            Ctrl_clk = Medium_on;
        end else if (Limpeza) begin
            Ctrl_clk = Slow_on;
        end else 
				Ctrl_clk = 0;
    end
endmodule

