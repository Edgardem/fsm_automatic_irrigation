module ContadorNivelAgua (
    input reset,
    input Ctrl_clk,
    input state,
    output reg [2:0] nivel
);

    // Lógica de contagem do nível da água
    always @(posedge Ctrl_clk or negedge reset) begin
        if (!reset) begin
            nivel <= 3'b000;
        end else begin
            if (!state) begin
                if (nivel > 3'b000) nivel <= nivel - 1;
            end else begin
                if (nivel < 3'b111) nivel <= nivel + 1;
            end
        end
    end

endmodule
