// Quartus II Verilog Template
// Unsigned Adder

module MultPO 
#(parameter WIDTH=3)
	(
	input [WIDTH-1:0] m,
	input [(WIDTH*2)-1:0] M,
	input clk,
	input s1,
	input s2,
	input en1,
	input en2,
	output reg ProxBit_m,
	output reg [1:0] CountOut,
	output [(WIDTH*2)-1:0] R
	);

reg [1:0] AdderOut, OutMux;
reg [(WIDTH*2)-1:0] R_reg;
reg [(WIDTH*2)-1:0] M_reg;
reg [WIDTH-1:0] m_reg;
//wire [WIDTH-1:0] m_regCon;

always@(m_reg, OutMux)
begin
	if (OutMux == 2'b00) 
		ProxBit_m <= 1'b0;
	else if (OutMux == 2'b01) 
		ProxBit_m <= m_reg[0];
	else if (OutMux == 2'b10) 
		ProxBit_m <= m_reg[1];
	else
		ProxBit_m <= m_reg[2];
end

always@(CountOut, AdderOut, s2)
begin
	if (s2 == 1'b1) 
		OutMux <= CountOut;
	else 
		OutMux <= AdderOut;
end

always@(CountOut)
begin
	AdderOut <= CountOut + 2'b01;
end

always@(posedge clk)
begin
		if (en1 == 1'b1)
			m_reg <= m;
		if (s1 == 1'b1)
			begin
				CountOut <= 2'b01;
				M_reg <= M;
				if (en2 == 1'b1)
					R_reg <= {(WIDTH*2){1'b0}};
			end
		else
			begin
				CountOut <= AdderOut;
				if (en2 == 1'b1)
					R_reg <= M_reg + R_reg;
				M_reg <= M_reg << 1;
			end
end

assign R = R_reg;


endmodule


