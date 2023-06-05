

module bit_perm(in,out);
input [127:0]in;
output reg [127:0]out;
reg [31:0] t1,t2,t3,t4,b1;

always @(in)
 begin
 out = 128'b0;
  t1 = in[127:96];
  t2 = in[95:64];
  t3 = in[63:32];
  t4 = in[31:0];

 b1 = permute(t1);
 out = out +b1;
  b1 = permute(t2);
 out =out << 32;
 out = out + b1;
  b1 = permute(t3);
 out =out << 32;
 out = out + b1;
 b1 = permute(t4);
 out =out << 32;
 out = out + b1;
end


function [31:0] permute;
input [31:0] in;
begin
 permute ={in[31],in[23],in[15],in[7],in[30],in[22],in[14],in[6],
         in[29],in[21],in[13],in[5],in[28],in[20],in[12],in[4],
         in[27],in[19],in[11],in[3],in[26],in[18],in[10],in[2],
         in[25],in[17],in[9],in[1],in[24],in[16],in[8],in[0]};

end
endfunction
endmodule 





module bit_test();
reg [127:0]in;
wire [127:0]out;
bit_perm p1(.in(in),.out(out));
 
//initialization
initial 
#2 in=128'h1234567890abcdef1234567890abcdef;

initial 
begin
# 3 $display ("input =%h ",in);
#20 $display("output of bit permutation is %h",out);
end

initial
#100 $stop;

endmodule