module sboxgen(sboxflat,clk,rst_an,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11);
integer i,j;
input clk;
input rst_an;
reg fb;
reg keygenflag;
reg [1:8] a[15:0][15:0];
output reg [2047:0]sboxflat;
reg [1:8] initial_value;
reg [8:0]size;
output reg [127:0]key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11;
reg [127:0]key12,key13,key14,key15,key16;
always @(posedge clk or negedge rst_an)
begin
	if(!rst_an)
	begin
		sboxflat=2048'b0;
		size=0;
		keygenflag=0;
	end
	else
	begin
	for(i=0; i<=15; i=i+1) 
  	begin
    		for(j=0; j<=15; j=j+1) 
     		 begin
             		if(i==0 & j==0)
			begin
                		initial_value = 8'b00011101;
			end
             		else
               		begin
				fb = initial_value[4] ^ initial_value[5] ^ initial_value[6] ^ initial_value[8];
			        initial_value = {fb, initial_value[1:7]};            
               		end
      			a[i][j] = initial_value;
      			if(size<256)
			begin
      				sboxflat=sboxflat<<8;
     	 			sboxflat = sboxflat + a[i][j];
      				//$display($time,"\t%h\t%d",sboxflat,size);
				size=size+1;
				//$display("%d",size);

			end
			else 
			begin
				sboxflat = sboxflat;
				size =size;
				//$display($time,"\t%h",sboxflat);
				keygenflag=1;
			end    // data_out = a[i][j];
    
      		end
  	end
	end
end

always@(keygenflag)
begin
	if(keygenflag)
	begin
	key1=sboxflat[2047:1920];
	key2=sboxflat[1919:1792];
	key3=sboxflat[1791:1664];
	key4=sboxflat[1663:1536];
	key5=sboxflat[1535:1408];
	key6=sboxflat[1407:1280];
	key7=sboxflat[1279:1152];
	key8=sboxflat[1151:1024];
	key9=sboxflat[1023:896];
	key10=sboxflat[895:768];
	key11=sboxflat[767:640];
	key12=sboxflat[639:512];
	key13=sboxflat[511:384];
	key14=sboxflat[383:256];
	key15=sboxflat[255:128];
	key16=sboxflat[127:0];
	/*$display("Key 1:%h",key1);
	$display("Key 2:%h",key2);
	$display("Key 3:%h",key3);
	$display("Key 4:%h",key4);
	$display("Key 5:%h",key5);
	$display("Key 6:%h",key6);
	$display("Key 7:%h",key7);
	$display("Key 8:%h",key8);
	$display("Key 9:%h",key9);
	$display("Key 10:%h",key10);
	$display("Key 11:%h",key11);
	$display("Key 12:%h",key12);
	$display("Key 13:%h",key13);
	$display("Key 14:%h",key14);
	$display("Key 15:%h",key15);
	$display("Key 16:%h",key16); */
	end
	
end

endmodule

module aaa;
reg clk;
reg rst_an;
reg [3:0]row,col;
wire [7:0]key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11;
wire [2047:0]sboxflat;

sboxgen dut(sboxflat,clk,rst_an,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11);
initial begin
rst_an=1;
rst_an=0;
#1 rst_an=1;
clk=0;

//#400 $display($time,"\t%h",sboxflat);

end
always
#5 clk = ~clk;
endmodule

