`timescale 1ns/1ns

module Mult3Bits_top #(parameter WIDTH=3)(
  input [WIDTH-1:0] m,
  input [(WIDTH*2)-1:0] M,
  input clk,
  input reset,
  input s1,
  input s2,
  input en1,
  input en2,
  output reg ProxBit_m,
  output reg [1:0] CountOut,
  output reg [(WIDTH*2)-1:0] R
);

  // Instância da FSM
  Mult3BitsFSM #(WIDTH) fsm_inst (
    .m(m),
    .M(M),
    .clk(clk),
    .reset(reset),
    .s1(s1),
    .s2(s2),
    .en1(en1),
    .en2(en2),
    .ProxBit_m(ProxBit_m),
    .CountOut(CountOut),
    .R(R)
  );

  // Instância da Parte Operativa
  MultPO #(WIDTH) po_inst (
    .m(m),
    .M(M),
    .clk(clk),
    .s1(s1),
    .s2(s2),
    .en1(en1),
    .en2(en2),
    .ProxBit_m(ProxBit_m),
    .CountOut(CountOut),
    .R(R)
  );

endmodule

