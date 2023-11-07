// # MIT License
// # Copyright (c) [2023] [Gabriel Rosa Dias]
// # See LICENSE file for full license text.

`timescale 1ns/1ps

module tb_module_top;
    reg clock;
    reg reset;

    wire select;
    reg [7:0] n;

    wire En_reg1;
    wire En_reg2;
    wire En_Count;
    wire En_N;
    
    // Saidas multiplexadores e somadores
    wire [7:0] Y_M1;
    wire [7:0] Y_M2;
    wire [7:0] Y_M3;
    wire [7:0] S_S1;
    wire [7:0] S_S2;

    wire [7:0] fibonacci;
    wire Stop;

    module_top #(.BUS_WIDTH(8)) FIBONACCI (
        .clock(clock),
        .reset(reset),
        .select(select),
        .En_reg1(En_reg1),
        .En_reg2(En_reg2),
        .En_Count(En_Count),
        .En_N(En_N),
        .fibonacci(fibonacci),
        .Stop(Stop),
        .n(n),
        .Y_M1(Y_M1),
        .Y_M2(Y_M2),
        .Y_M3(Y_M3),
        .S_S1(S_S1),
        .S_S2(S_S2)
    );

    control_unit FSM(
        .clock(clock),
        .reset(reset),
        .Stop(Stop),
        .En_reg1(En_reg1),
        .En_reg2(En_reg2),
        .En_Count(En_Count),
        .En_N(En_N),
        .Select(select)
    );

    always begin
        #5 clock = ~clock;
    end

    initial begin
        // Inicialize os sinais
        clock = 0;
        reset = 1;

        n = 10;
        #10 reset = 0;

        wait (FSM.estado_atual == 2'b10); // Espera a FSM chegar no estado F0 para começar a testar novo valor de n
        #5 reset = 1;
        n = 15;
        #10 reset = 0;

        wait (FSM.estado_atual == 2'b10); // Espera a FSM chegar no estado F0 para começar a testar novo valor de n
        #10 reset = 1;
         

    end

endmodule
