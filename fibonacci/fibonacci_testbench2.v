`timescale 1ns/1ns

module fibonacci_top_tb #(parameter WIDTH_TB=8);
    reg clock_tb;
    reg reset_tb;
    wire [7:0] fibonacci_tb;
    reg [7:0] n_tb;

    fibonacci_top #(WIDTH_TB) fibonacci_top_inst(
    .clock(clock_tb),
    .reset(reset_tb),
    .fibonacci(fibonacci_tb),
    .n(n_tb)
    );

    // Gerando um clock
    always
    begin
        #5 clock_tb = ~clock_tb;
    end

    // InicializaÃ§Ã£o
    initial
    begin
        clock_tb = 0;
        reset_tb = 1;
        n_tb = 10; // Defina o valor de n conforme necessÃ¡rio

        //reset = 1;
        #10 reset_tb = 0;

        // Aguardar algum tempo para que os cÃ¡lculos ocorram
        #100;

        // Verificando os resultados
        // $display("Resultado Fibonacci: %d", fibonacci);
        // $finish;
    end

    // SimulaÃ§Ã£o de estÃ­mulo
    // always
    // begin
    //     #20 n = 5; 
    //     #20 n = 8; 
    //     #20 n = 12; 
    //     #20 n = 3; 
    //     #20 n = 6; 
    //     #20 n = 9; 
    //     $finish;
    // end

endmodule
