	module NivelAguaControl (
    input reset,
    input start_fill,
    input Ctrl_clk,
    output reg [2:0] nivel, // Nível atual de água: 0 a 7
    output reg Esvaziar
);
		
    // Parâmetros para os estados
    parameter FILLING = 1'b0;
    parameter EMPTYING = 1'b1;

    // Estados
    reg [1:0] state, next_state;

    // Lógica de estado e transições
    always @(posedge Ctrl_clk or negedge reset) begin
        if (!reset) begin
            state <= FILLING; // Inicia no estado FILLING
            nivel <= 3'b000;
            Esvaziar <= 0;
        end else begin
            state <= next_state;
            case (state)
                FILLING: begin
                    if (nivel < 3'b111) nivel <= nivel + 1;
                    Esvaziar <= 0;
                end
                EMPTYING: begin
                    if (nivel > 3'b000) nivel <= nivel - 1;
                    Esvaziar <= 1;
                end
                default: begin
                    nivel <= 3'b000;
                    Esvaziar <= 0;
                end
            endcase
        end
    end

    // Lógica de próxima transição
    always @(*) begin
        case (state)
            FILLING: begin
                if (!start_fill && nivel >= 3'b111) next_state = EMPTYING;
                else next_state = FILLING;
            end
            EMPTYING: begin
                if (start_fill && nivel <= 3'b000) next_state = FILLING;
                else next_state = EMPTYING;
            end
            default: next_state = FILLING; // Caso de segurança
        endcase
    end
endmodule