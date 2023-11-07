// # MIT License
// # Copyright (c) [2023] [Gabriel Rosa Dias]
// # See LICENSE file for full license text.

module control_unit(
    input clock,
    input reset,
    input Stop,
    output reg En_reg1,
    output reg En_reg2,
    output reg En_Count,
    output reg En_N,
    output reg Select
);

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter F0 = 2'b10;
	 
    // Definição dos sinais internos
    reg [1:0] estado_atual;
    reg [1:0] prox_estado;

    always @(posedge clock) begin
        if(reset) 
            begin
                estado_atual <= S0;
            end 
        else
            begin
                estado_atual <= prox_estado;
            end
    end

    always @(posedge clock or negedge Stop)
        begin
            case(estado_atual)
                S0: 
                    prox_estado <= S1;
                S1:
                    if(Stop)
                        begin
                            prox_estado <= F0;
                        end
                F0:
                    prox_estado <= S0;
            endcase
        end

    always @(posedge clock or negedge reset) begin
        if (reset) 
            begin
                prox_estado <= S0; // Reinicie para o estado de repouso quando o reset for acionado
                En_reg1 <= 1'b0;
                En_reg2 <= 1'b0;
                En_Count <= 1'b0;
                En_N <= 1'b0;
            end
        else 
            begin
                case (estado_atual)
                    S0: 
                        begin
                            En_reg1 <= 1'b0;
                            En_reg2 <= 1'b0;
                            En_Count <= 1'b0;
                            En_N <= 1'b1;
                            Select <= 1'b1;
                        end
                    S1: 
                        begin
                            En_reg1 <= 1'b1;
                            En_reg2 <= 1'b1;
                            En_Count <= 1'b1;
                            En_N <= 1'b0;
                            Select <= 1'b0;    
                        end
                    F0: 
                        begin
                            En_reg1 <= 1'b0;
                            En_reg2 <= 1'b0;
                            En_Count <= 1'b0;
                            En_N <= 1'b0;
                        end
                endcase
            end
        end
endmodule
