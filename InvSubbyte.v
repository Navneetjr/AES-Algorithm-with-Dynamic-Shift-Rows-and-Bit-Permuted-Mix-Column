module newsbox(dataout,clk,rst_an,rowcol,select);
integer i,j,k,m;
input clk;
input select;//1 encyrpt
input rst_an;
input [7:0]rowcol;
reg fb;
reg [1:8] initial_value;
reg [1:8] a[15:0][15:0];
reg [1:8] b[15:0][15:0];
output reg [7:0]dataout;

always @(posedge clk or negedge rst_an)
begin
	if(!rst_an)
	begin
		initial_value = 8'h1D;
	end
	else
	begin
	for(i=0; i<=15; i=i+1)
  	begin
    		for(j=0; j<=15; j=j+1)
     		 begin
             		if(i==0 & j==0)
			        begin
                		initial_value = 8'h1D;
			        end
             		else
               		begin
				    fb = initial_value[4] ^ initial_value[5] ^ initial_value[6] ^ initial_value[8];
			        initial_value = {fb, initial_value[1:7]};
               		end
      				a[i][j] = initial_value;
      				b[initial_value[1:4]][initial_value[5:8]] = {i[3:0],j[3:0]};
      		end

  	end
  	a[15][15]=8'b00;
  	b[1][13]=8'h00;
  	b[0][0]=8'hff;
	end
if(select)
 dataout=a[rowcol[7:4]][rowcol[3:0]];
 else
  dataout=b[rowcol[7:4]][rowcol[3:0]];
end
endmodule

module subBytes(in,out,clk,rst_an,select);
input [127:0] in;
output [127:0] out;
input clk,rst_an;
input select;
genvar i;
generate
for(i=0;i<128;i=i+8) begin :sub_Bytes
	newsbox hi(out[i +:8],clk,rst_an,in[i +:8],select);
	end

endgenerate

endmodule

module subbytetb_final;

reg [127:0]in;
reg clk,select;
reg rst_an;
wire [127:0]out1;


subBytes inst(in,out1,clk,rst_an,select);

initial
begin

rst_an = 1'b0;
rst_an =1'b1;
clk=0;
select=0;
#1 in   = 128'h52651d0585e4d181941d19428ae0d0f4;

#10;
$monitor("Out:%h",out1);

end

always #5 clk=~clk;
endmodule
