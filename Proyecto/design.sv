/ Code your design here
module PC(
  input clk,
  input reset,
  output [10:0] salida
);
  reg[10:0] salida;
  always @ (posedge clk)
    if (reset)
      begin
        salida <= 1'b0;
      end
  	else 
      begin
        salida <= salida + 1;
      end
    
  initial 
    begin
      salida <= 1'b0;
  	end
endmodule

module Memoria(
  input [10:0] contador,
  input clk,
  output reg enable,
  output [3:0] alu,
  output [6:0] addr
);
  reg [3:0] alu;
  reg [6:0] addr;
  reg [11:0] memory [0:1024];
  reg [11:0] temporal;
  
  always @ (posedge clk)
    if(enable)
      begin
        temporal <= memory[contador];
        enable <= temporal[11];
        alu <= temporal[10:6];
        addr <= temporal[6:0];
      end
  initial
    begin
      $readmemh("memory.list",memory);
    end
endmodule  

module ALU(
  input [3:0] mselector, 
  input [7:0] W,
  input [7:0] F,
  input clk,
  output [7:0] out
);
  reg [7:0] out;
  always @ (posedge clk)
    case(mselector)
      0: out <= F;
      //regresa f = 0
      1: out <= 0;
      2: out <= W - F;
      3: out <= F - 1;
      4: out <= W || F;
      5: out <= W && F;
      6: out <= W ^ F;
      7: out <= W + F;
      8: out <= F;
      9: out <= ~F;
      10: out <= F + 1;
      12: out <= F << 0;
      13: out <= F >> 0;
  //hacer cases para cada instruccion segun el selector y la tablita in A in B
    endcase
endmodule

module Registros(
  input [6:0] addr,
  input [7:0] datain,
  	input clk,
  	input enable,
  output [7:0] out
);
  reg [7:0] out;
  reg [7:0] memoria [0:123];
  assign  out = memoria[addr];
  always @ (posedge clk)
    if(enable)
      begin
        memoria[addr] <= datain;
      end
 //si enable  guarda en la memoria
  //asigna  out memoria[addr]
  // data in en out si es enable
endmodule

module WReg(
  input enable,
  input clk,
  input [7:0] outALU, 
  output [7:0] out
);
  //solo si es enable saca el valr
  reg [7:0] out;
  always @ (posedge clk)
    if(enable)
      begin
        out <= outALU;
      end
endmodule


module freqDivisor(input clk, input reset, output reg out);
  
  always @ (posedge clk) begin
    if(reset)
      out <= 1'b0;
    else
      out <= ~out;
  end
  
  initial begin
    out <= 1'b0;
  end
endmodule
