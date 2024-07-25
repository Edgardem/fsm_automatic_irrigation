// Declaração do módulo FILL
module FILL (
    input Vazio,
    input Nivel_cheio,
    input clk,
    input reset,
    output reg state
);

    // Declaração de estados
    reg nextstate;

    // Parâmetros de Estados
    parameter IDLE = 1'b0;
    parameter FILLING = 1'b1;

    // Estado do registrador
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            state <= IDLE;
        end else begin
            state <= nextstate;
        end
    end

    // Lógica de próximo estado e saída
    always @(*) begin
        case (state)
            IDLE: begin
                if (Vazio) begin
                    nextstate = FILLING;
                end else begin
                    nextstate = IDLE;
                end
            end
            FILLING: begin
                if (Nivel_cheio) begin
                    nextstate = IDLE;
                end else begin
                    nextstate = FILLING;
                end
            end
            default: nextstate = IDLE;
        endcase
    end

endmodule
