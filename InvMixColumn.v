
module inversemixcolumn(in,out);
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
		sdash[0][i]=(mule(s[0][i]))^(mulb(s[1][i]))^(muld(s[2][i]))^(mul09(s[3][i]));
		sdash[1][i]=(mul09(s[0][i]))^(mule(s[1][i]))^(mulb(s[2][i]))^(muld(s[3][i]));
		sdash[2][i]=(muld(s[0][i]))^(mul09(s[1][i]))^(mule(s[2][i]))^(mulb(s[3][i]));
		sdash[3][i]=(mulb(s[0][i]))^(muld(s[1][i]))^(mul09(s[2][i]))^(mule(s[3][i]));
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



function [7:0] mul09;
	input [7:0] x;
        reg [7:0] m;
        integer i;
	begin
                        m = x;
			for(i=0;i<3;i=i+1)
                           begin
                             m= mul2(m);

                           end
m = m ^x;
mul09=m;
	end
endfunction

function [7:0] mule;
	input [7:0] x;
        reg [7:0] m,m1,m2,m3;
        integer i;
	begin
                        m1 = x;
                        m2 = x;
			m3=x;

			for(i=0;i<3;i=i+1)
                           begin
                             m1= mul2(m1);
                            // $display("%d",m1);
                           end

                       for(i=0;i<2;i=i+1)
                           begin
                             m2= mul2(m2);
                           end
                             m3 = mul2(m3);
m = m1 ^ m2 ^ m3;
mule=m;
	end
endfunction

function [7:0] muld;
	input [7:0] x;
        reg [7:0] m,m1,m2;
        integer i;
	begin
                        m1 = x;
                        m2 = x;

			for(i=0;i<3;i=i+1)
                           begin
                             m1= mul2(m1);
                            // $display("%d",m1);
                           end

                       for(i=0;i<2;i=i+1)
                           begin
                             m2= mul2(m2);
                           end

m = m1 ^ m2 ^ x;
muld=m;
	end
endfunction

function [7:0] mulb;
	input [7:0] x;
        reg [7:0] m,m1,m2;
        integer i;
	begin
                        m1 = x;
                        m2 = x;

			for(i=0;i<3;i=i+1)
                           begin
                             m1= mul2(m1);
                            // $display("%d",m1);
                           end
                             m2= mul2(m2);
m = m1 ^ m2 ^ x;
mulb=m;
	end
endfunction
endmodule

module inversemix_tb();
reg [127:0]in;
wire [127:0]out;
inversemixcolumn m1(.in(in),.out(out));

//initialization
initial
//in=128'h00112233445566778899aabbccddeeff;
in = 128'h22bae9d41752b95f4833aa80afa3b783;
initial
$monitor("%h",out);

initial
#20 $stop;

endmodule




