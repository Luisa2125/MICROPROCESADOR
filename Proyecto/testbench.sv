// Code your testbench here
// or browse Examples
//declaro todas la variables
//divisor de frecuencias para los clocks en el initial begin
//

module testbench();
  reg clk;
  wire clk1;
  wire clk2;
  wire clk3;
  wire clk4;
  
  reg reset;
  wire [10:0] salida;
  wire [10:0] PCsalida;
  wire enable;
  reg [3:0] mALUSalida;
  reg [6:0] mAddrSalida;
  reg [7:0] WregSalida;
  reg [7:0] DataOutF;
  reg [7:0] ALUSalida;
  
  wire fetchInstr;
  wire fetchData;
  wire outAlu;
  wire fileSave;
 
  not n (clk1, clk);
  not n (clk3, clk2);
  and andA (fetchInstr, clk, clk2);
  and andB (fetchData, clk1, clk2);
  and andC (outAlu, clk, clk3);
  and andD (fileSave, clk1, clk3);
  freqDivisor clkDiv1 (clk, reset, clk2);
  freqDivisor clkDiv2 (clk2, reset, clk4);

  PC pc (clk3,reset,salida);
  Memoria m (salida,fetchData,enable,mALUSalida,mAddrSalida);
  ALU al (mALUSalida,WregSalida,DataOutF,fetchInstr,ALUSalida);
  WReg wr (enable,fileSave,ALUSalida,WregSalida); 
  Registros r (mAddrSalida, ALUSalida, fileSave, enable, DataOutF);
  initial begin
    #1  reset = 0;
    #1	clk = 0;
    #1	clk = 1;
    #1	clk = 0;
    #1	clk = 1;
    #1	clk = 0;
    #1	clk = 1;
    #1	clk = 0;
    #1	clk = 1;
    #1	clk = 0;
    #1	clk = 1;
    #1	clk = 0;
    #1	clk = 1;
    #1	clk = 0;
    #1	clk = 1;
    #1	clk = 0;
    #1	clk = 1;
    #1	clk = 0;
    #1	clk = 1;
    #1	clk = 0;
    #1	clk = 1;
    #1  reset = 1;
  end
  initial
    #100 $finish;
  initial
     begin
       $display ("\tPC\t\tInstrucciones\tSalida");
       $monitor("\t%b\t%b\t%d", salida, enable, ALUSalida);
     end
  
  
  
endmodule