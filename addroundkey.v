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
