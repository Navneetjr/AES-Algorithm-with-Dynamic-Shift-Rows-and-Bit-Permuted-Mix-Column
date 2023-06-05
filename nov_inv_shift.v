module nov_inv_shiftrow(in,out);
input [127:0] in;
output reg [127:0] out;
integer i;
always @(in)
begin
{out[127:120],out[95:88],out[63:56],out[31:24]} = {in[127:120],in[95:88],in[63:56],in[31:24]}; 
{out[119:112],out[87:80],out[55:48],out[23:16]} = {in[87:80],in[55:48],in[23:16],in[119:112]};
	if (^in)
	begin
	{out[111:104],out[79:72],out[47:40],out[15:8]} =  {in[47:40],in[15:8],in[111:104],in[79:72]};
     	{out[103:96],out[71:64],out[39:32],out[7:0]} =    {in[103:96],in[71:64],in[39:32],in[7:0]} ;
		if (^in[23:16] && ^in[119:112] && ^in[87:80] && ^in[55:48])
			 {out[127:120],out[95:88],out[63:56],out[31:24]} ={out[31:24],out[127:120],out[95:88],out[63:56]};
		else
			 {out[127:120],out[95:88],out[63:56],out[31:24]} = { in[63:56],in[31:24],in[127:120],in[95:88]};
	end
	else
	begin
       {out[111:104],out[79:72],out[47:40],out[15:8]} =  {in[111:104],in[79:72],in[47:40],in[15:8]};
       {out[103:96],out[71:64],out[39:32],out[7:0]} =    {in[7:0],in[103:96],in[71:64],in[39:32]}; 
		 if (^in[23:16] && ^in[119:112] && ^in[87:80] && ^in[55:48])
			 {out[127:120],out[95:88],out[63:56],out[31:24]} ={out[31:24],out[127:120],out[95:88],out[63:56]};
		else
			 {out[127:120],out[95:88],out[63:56],out[31:24]} = { in[63:56],in[31:24],in[127:120],in[95:88]};
	end
$display("%m:::Shift Rows Out:%h",out);   
end

endmodule

module nov_inv_shiftrow_tb;
reg [127:0] in;
wire [127:0] out;
nov_inv_shiftrow m2(.in(in), .out(out));
initial begin
//in=128'he8598b1b402ea1c3f23813421e84e7d6;
#1 in=128'haa61733dd35c09d457ed90145a54cf08;
$display("%b",^in);
$display("%b",^in[23:16] && ^in[119:112] && ^in[87:80] && ^in[55:48]);
end
initial
#5 $display("%h",out);
endmodule
