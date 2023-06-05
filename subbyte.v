module subbyte (in,sboxflat,out);
input [127:0]in;
input [2047:0]sboxflat;
output reg [127:0]out; 
reg [2047:0]temp_flat;
reg [7:0]temp;    
reg [127:0]in_temp;
integer i;
always @(in or sboxflat)
begin

	in_temp=in;
	out=128'b0;
for(i=0;i<16;i=i+1)
begin
	temp = in_temp[127:120];  
	//$display("%h",temp);
	temp_flat = sboxflat<<(8*temp);   
	//$display("%h",temp_flat);
	out = out<<8;
	out = out + temp_flat[2047:2040];   
	in_temp = in_temp<<8;
	end
	$display("%m:::Subbyte Out:%h",out);
end               
endmodule         

module subbytetb_final;

reg [127:0]in;
reg [2047:0]sboxflat;
wire [127:0]out;


subbyte s1 (in,sboxflat,out);

initial 
begin  
#1 in   = 128'h5a4ea44fb61410af0ca81cd1a4813475;
#1 sboxflat = 2048'h1d0e070381c06030984c2693492492c964b2d9ec763b9d4e271309048241a050a8d46ab5da6db65badd66b359a4da6d369341a0d86c3e1f0f87cbedf6fb7dbedf67bbd5eafd7eb75ba5d2e178b4522110884c261b0d86c361b8dc6e3f1783c9ecfe773399cce6733198c46a3d168b45a2d964b25128944a25128944aa552a9542a95cae572b9dcee77bbdd6e379bcde6f379bcdeeff7fbfd7ebf5f2f97cb653299cc66b359ac562b158ac56231180c0683c1e070b85cae57ab55aad5eaf5fa7d3e9f4fa75329140a85422190c8e4f2f9fcfeff7f3f1f0f8743a1d0e8f47a3d1e8fc763b1582c160b0502018040201088c4e271381c8e47239148a4d2e9743a00;


$monitor("Out:%h",out);
end     
endmodule



