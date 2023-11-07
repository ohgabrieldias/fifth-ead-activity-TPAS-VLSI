// # MIT License
// # Copyright (c) [2023] [Gabriel Rosa Dias, Pedro Antônio]
// # See LICENSE file for full license text.

module Mult3BitsFSM #(parameter WIDTH=3)(
    input [WIDTH-1:0] m,
    input [(WIDTH*2)-1:0] M,
    input clk,
    input s1,
    input s2,
    input en1,
    input en2,
    output reg ProxBit_m,
    output [1:0] CountOut,
    output [(WIDTH*2)-1:0] R
);

    // Definição dos estados
    reg [1:0] estado;
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
	 
    // Definição dos sinais internos
    reg [1:0] estado_atual;
    reg [1:0] prox_estado;

    always @(posedge clk) begin
        if(reset) 
            begin
                estado_atual <= S0;
            end 
        else
            begin
                estado_atual <= prox_estado;
            end
    end

    always @(posedge clk) begin
        begin
            case(estado_atual)
                S0: 
                    if(ProxBit_m == 1)
                        begin
                            prox_estado <= S1;
                        end
                    else if(ProxBit_m == 0)
                        begin
                            prox_estado <= S2;
                        end
                    else if(reset)
                        begin
                            prox_estado <= S0;
                        end
                S1: 
                    if(countOut > 0 && ProxBit_m = 1)
                        begin
                            prox_estado <= S1;
                        end
                    else if(countOut == 0)
                        begin
                            prox_estado <= S3;
                        end
                    else if(reset)
                        begin
                            prox_estado <= S0;
                        end
                S2: 
                    if(countOut > 0 && ProxBit_m = 0)
                        begin
                            prox_estado <= S2;
                        end
                    else if(countOut > 0 && ProxBit_m = 1)
                        begin
                            prox_estado <= S1;
                        end
                    else if(countOut == 0)  
                        begin
                            prox_estado <= S3;
                        end
                S3:
                    if(reset)
                        begin
                            prox_estado <= S0;
                        end
                    else if(reset)
                        begin
                            prox_estado <= S3;
                        end
            endcase
        end
    end
    
    always @(posedge clk) begin
        case(estado_atual)
            S0: 
                begin
                    ProxBit_m <= 0;
                    CountOut <= 0;
                    R <= 0;    
                end

            S1: 
                begin
                    ProxBit_m <= 1;
                    CountOut <= CountOut - 1;
                    R <= R + M;
                end
            S2: 
                begin
                    ProxBit_m <= 0;
                    CountOut <= CountOut - 1;
                    R <= R;
                end
            S3: 
                begin
                    ProxBit_m <= 0;
                    CountOut <= 0;
                    R <= R;
                end
        endcase
    end

endmodule