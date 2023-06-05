module mixcolumn(in,out);
input [127:0]in;
output reg [127:0]out;
reg [127:0]in_temp;
reg [7:0]swap;
reg [7:0]s[3:0][3:0];
reg [7:0]sdash[3:0][3:0];
integer i,j,k;
always @(in)
begin   
	in_temp=in; 
	out=128'b0;
	for(i=0;i<4;i=i+1) //column
	begin
		for(j=0;j<4;j=j+1) //row
		begin
		s[j][i]= in_temp[127:120];
		in_temp= in_temp<<8;  
		end
	end

	for(i=0;i<4;i=i+1)
	begin
		sdash[0][i]=(mul2(s[0][i]))^(mul3(s[1][i]))^s[2][i]^s[3][i];
		sdash[1][i]=s[0][i]^(mul2(s[1][i]))^s[3][i]^(mul3(s[2][i]));
		sdash[2][i]=s[0][i]^(mul2(s[2][i]))^s[1][i]^(mul3(s[3][i]));
		sdash[3][i]=mul3(s[0][i])^((s[1][i]))^s[2][i]^mul2((s[3][i]));
	end

	for (i=0;i<4;i=i+1)
	begin
	   for(j=0;j<4;j=j+1)
	   begin
	      out = out<<8;
	      out =out+sdash[j][i];
	   end
	end

$display("%m Mix Column output:%h",out);
end

function [7:0] mul2;
	input [7:0] x;
	begin
			if(x[7] == 1)
			mul2 = ((x << 1) ^ 8'h1b);
			else
			mul2 = x << 1;
	end
endfunction

function [7:0]mul3;
    input [7:0]x;
    begin
            if(x[7] == 1)
			mul3 = ((x << 1) ^ 8'h1b);
			else
			mul3 = x << 1;

			mul3=mul3^x;
    end
endfunction
endmodule

module mix_tb();
reg [127:0]in;
wire [127:0]out;
mixcolumn m1(.in(in),.out(out));

//initialization
initial
//in=128'h00112233445566778899aabbccddeeff;
in = 128'hD4F27DDAC96710727221C9F04D636772;

initial
$monitor("%h",out);

initial
#20 $stop;

endmodule



