`timescale 1ns/1ns

module Mult3Bits_tb;

  // Parâmetros
  parameter WIDTH = 3;

  // Sinais de entrada
  reg [WIDTH-1:0] m;
  reg [(WIDTH*2)-1:0] M;
  reg clk;
  reg reset;
  reg s1;
  reg s2;
  reg en1;
  reg en2;

  // Sinais de saída
  wire ProxBit_m;
  wire [1:0] CountOut;
  wire [(WIDTH*2)-1:0] R;

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

  // Geração de clock
  always #5 clk = ~clk;

  // Inicialização
  initial begin
    // Inicialização de sinais
    m = 3'b001;
    M = 6'b000100;
    clk = 0;
    reset = 1;
    s1 = 0;
    s2 = 0;
    en1 = 0;
    en2 = 0;

    // Aguarde alguns ciclos
    #10 reset = 0;

    // Execute todos os estados da FSM
    #25 s1 = 1;
    #25 s1 = 0;
    
    
    #25 s2 = 1;
    #25 s2 = 0;
   
    
    #25 en1 = 1;
    #25 en1 = 0;
    
    
    #25 en2 = 1;
    #25 en2 = 0;
   
    
    #25 reset = 1;

    // Aguarde alguns ciclos para observar os resultados
    #100 $stop;
  end

endmodule
