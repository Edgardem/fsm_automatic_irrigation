module ControleRega (
    input [1:0] REGA_Mode,
    input Esvaziar,
    input Nivel_cheio,
    input Parada_Rega,
	 input Limpeza,
    output reg Aspersao,
    output reg Gotejamento,
    output reg ERRO
);

    always @(*) begin
        Aspersao = ((REGA_Mode == 2'b01) && Esvaziar && !Parada_Rega && !Limpeza) || ((REGA_Mode == 2'b01) && Nivel_cheio);
        Gotejamento = ((REGA_Mode == 2'b10) && Esvaziar && !Parada_Rega && !Limpeza) || ((REGA_Mode == 2'b10) && Nivel_cheio);
        ERRO = ((REGA_Mode == 2'b11) && Esvaziar && !Limpeza) || ((REGA_Mode == 2'b11) && Nivel_cheio);
    end

endmodule