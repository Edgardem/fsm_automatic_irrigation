module ControladorMatriz (
    input [2:0] nivel,
    output reg [6:0] linhas_Matriz
);

    always @(*) begin
        case (nivel)
            3'b000: linhas_Matriz = 7'b1111111;
            3'b001: linhas_Matriz = 7'b0111111;
            3'b010: linhas_Matriz = 7'b0011111;
            3'b011: linhas_Matriz = 7'b0001111;
            3'b100: linhas_Matriz = 7'b0000111;
            3'b101: linhas_Matriz = 7'b0000011;
            3'b110: linhas_Matriz = 7'b0000001;
            3'b111: linhas_Matriz = 7'b0000000;
            default: linhas_Matriz = 7'b1111111; 
        endcase
    end

endmodule
