// Declaração do módulo FERTILIZING
module FERTILIZING (
    input Aspersao,
    input Vazio,
    input B_Adb,
    input clk,
    input reset,
    output Mist_Adb,
    output Adubou
);

    // Declaração de estados
    reg state, nextstate;

    // Parâmetros de Estados
    parameter IDLE = 1'b0;
    parameter FERTILIZING = 1'b1;

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
                if (Aspersao && !B_Adb) begin
                    nextstate = FERTILIZING;
                end else begin
                    nextstate = IDLE;
                end
            end
            FERTILIZING: begin
                if (Vazio) begin
                    nextstate = IDLE;
                end else begin
                    nextstate = FERTILIZING;
                end
            end
            default: nextstate = IDLE;
        endcase
    end

    // Lógica das saídas
    assign Mist_Adb = (state == FERTILIZING && Aspersao);
    assign Adubou = (state == FERTILIZING);

endmodule


