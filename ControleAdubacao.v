module ControleAdubacao (
    input Adubou,
    input [2:0] nivel,
    output reg Parada_Rega,
    output reg Limpeza,
    output reg Vazio
);

    always @(*) begin
        Parada_Rega = (!Adubou && (nivel == 3'b001)) || (Adubou && (nivel == 3'b010));
        Limpeza = Adubou && (nivel <= 3'b010);
        Vazio = (!Adubou && Parada_Rega) || (nivel == 3'b000);
    end

endmodule