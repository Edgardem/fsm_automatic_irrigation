/*module ControladorDisplay (
    input ERRO,
    input Aspersao,
    input Gotejamento,
    input Limpeza,
    output reg [6:0] Segs
);

    wire [3:0] letras;
    assign letras = {Aspersao, Gotejamento, Limpeza, ERRO};

    always @(*) begin
        case (letras)
            4'b1000: Segs = 7'b0001000; 	// Letra A de Aspersão
            4'b0100: Segs = 7'b0000100;	// Letra G de Gotejamento
            4'b0010: Segs = 7'b1110001;	// Letra L de Limpeza
				4'b0001: Segs = 7'b0110000;	// Letra E de Erro
            default: Segs = 7'b1111111; 	// Desligado 
        endcase
    end

endmodule */

module ControladorDisplay (
    input ERRO,
    input Aspersao,
    input Gotejamento,
    input Limpeza,
    output reg [6:0] Segs
);

    wire [3:0] letras;
    assign letras = {Aspersao, Gotejamento, Limpeza, ERRO};

    always @(*) begin
        case (letras)
            4'b1000: Segs = 7'b0001000; 	// Letra A de Aspersão
            4'b0100: Segs = 7'b0010000;		// Letra G de Gotejamento
            4'b0010: Segs = 7'b1000111;		// Letra L de Limpeza
				4'b0001: Segs = 7'b0000110;		// Letra E de Erro
            default: Segs = 7'b1111111; 	// Desligado 
        endcase
    end

endmodule 