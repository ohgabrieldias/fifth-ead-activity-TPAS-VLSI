// # MIT License
// # Copyright (c) [2023] [Gabriel Rosa Dias]
// # See LICENSE file for full license text.

module module_top #(parameter BUS_WIDTH=8)(
    input clock,
    input reset,
    input wire select,
    input [7:0] n,
    input En_reg1,
    input En_reg2,
    input En_Count,
    input En_N,
    output wire [BUS_WIDTH-1:0] Y_M1,
    output wire [BUS_WIDTH-1:0] Y_M2,
    output wire [BUS_WIDTH-1:0] Y_M3,
    output wire [BUS_WIDTH-1:0] S_S1,
    output wire [BUS_WIDTH-1:0] S_S2,
    output wire Stop,
    output reg [7:0] fibonacci
    
);

    parameter const1 = 8'b00000001,
        const0 = 8'b00000000;

    reg [BUS_WIDTH - 1:0] reg1;
    reg [BUS_WIDTH - 1:0] reg2;
    reg [BUS_WIDTH - 1:0] regn;
    reg [BUS_WIDTH - 1:0] reg_count_to_n;

    wire [BUS_WIDTH - 1:0] saida_mux1;
    wire [BUS_WIDTH - 1:0] saida_mux2;
    wire [BUS_WIDTH - 1:0] saida_mux3;
    wire [BUS_WIDTH - 1:0] saida_somador1;
    wire [BUS_WIDTH - 1:0] saida_somador2;

    somador #(BUS_WIDTH) sumFibon (
        .A(reg1),
        .B(reg2),
        .S(saida_somador1)
    );

    somador #(BUS_WIDTH) sumCount (
        .A(const1),
        .B(reg_count_to_n),
        .S(saida_somador2)
    );

    mux2to1 #(BUS_WIDTH) multipl1 (
        .A(const0),
        .B(reg2),
        .Select(select),
        .Y(saida_mux1)
    );

    mux2to1 #(BUS_WIDTH) multipl2 (
        .A(const1),
        .B(saida_somador1),
        .Select(select),
        .Y(saida_mux2)
    );

    mux2to1 #(BUS_WIDTH) multipl3 (
        .A(const1),
        .B(saida_somador2),
        .Select(select),
        .Y(saida_mux3)
    );

    comparador #(BUS_WIDTH) comparad (
        .A(reg_count_to_n),
        .B(regn),
        .S(Stop)
    );

    assign Y_M1 = saida_mux1;
    assign Y_M2 = saida_mux2;
    assign Y_M3 = saida_mux3;
    assign S_S1 = saida_somador1;
    assign S_S2 = saida_somador2;


    always @(posedge clock) begin
        if (reset) begin
            reg1 <= const1;
            reg2 <= const0;
            regn <= n;
            reg_count_to_n <= const1;
            fibonacci <= const0;
        end
        else
            begin
                if(En_N)
                    begin
                        regn <= n;
                    end
                if(En_reg1 && En_reg2 && !Stop)
                    begin
                        reg1 <= saida_mux1;
                        reg2 <= saida_mux2;
                        fibonacci <= reg1;
                    end
    
                if(En_Count && !Stop)
                    begin
                        reg_count_to_n <= saida_mux3;
                    end
            end
    end
endmodule

module mux2to1 #(parameter BUS_WIDTH = 8)(
    input wire [BUS_WIDTH-1:0] A,
    input wire [BUS_WIDTH-1:0] B,
    input wire Select,
    output wire [BUS_WIDTH-1:0] Y
);
    assign Y = (Select) ? A : B; //se 0 Y = B, se 1 Y = A
endmodule

module somador #(parameter BUS_WIDTH = 8)(
    input wire [BUS_WIDTH-1:0] A,
    input wire [BUS_WIDTH-1:0] B,
    output wire [BUS_WIDTH-1:0] S
);
    assign S = A + B;
endmodule

module comparador #(parameter BUS_WIDTH = 8)(
    input [7:0] A,
    input [7:0] B,
    output wire S
);
    assign S = (A == B);
endmodule