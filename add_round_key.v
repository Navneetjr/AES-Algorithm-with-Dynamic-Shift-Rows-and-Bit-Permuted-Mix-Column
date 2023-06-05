//module for round key
module addroundkey(plaintext,key,roundkey);
input [127:0] plaintext;
input [127:0]  key;
output reg [127:0] roundkey;

always@(plaintext or key)
begin

roundkey = plaintext ^ key;
 $display("%m:::Addroundkey Output:%h", roundkey);

end
endmodule


/* module addroundkey_tb;
reg [127:0] plaintext,key;
wire [127:0] roundkey;
addroundkey dut(.plaintext(plaintext), .key(key), .roundkey(roundkey));
initial
begin
 plaintext = 128'h4740A34C37D4709F94E43A42EDA5A6BC;
 key = 128'hAC19285777FAD15C66DC2900F321416A; 
end
initial
#2 $display("%h", roundkey);
endmodule */
