module decrypt (cipher,plain,clk,rst_an,select);
input [127:0]cipher;
output  [127:0]plain;
input clk,rst_an,select;
wire [127:0]key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,initkey;
wire [127:0]w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12;
//sboxgen1 keyy(clk,rst_an,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11);
assign initkey=128'h1d0e070381c06030984c2693492492c9;
keygen k1(initkey,key1,1);
keygen k2(key1,key2,2);
keygen k3(key2,key3,3);
keygen k4(key3,key4,4);
keygen k5(key4,key5,5);
keygen k6(key5,key6,6);
keygen k7(key6,key7,7);
keygen k8(key7,key8,8);
keygen k9(key8,key9,9);
keygen k10(key9,key10,10);
keygen k11(key10,key11,1);

addroundkey a1 (cipher,key11,w1);
nov_inv_shiftrow isr1(w1,w2);
subBytes sb1(w2,w3,clk,rst_an,select);


decrypt_round r1(.dec_round_in(w3), .dec_round_out(w4),.dec_round_key(key10),.select(select),.clk(clk),.rst_an(rst_an));
decrypt_round r2(.dec_round_in(w4), .dec_round_out(w5),.dec_round_key(key9),.select(select),.clk(clk),.rst_an(rst_an));
decrypt_round r3(.dec_round_in(w5), .dec_round_out(w6),.dec_round_key(key8),.select(select),.clk(clk),.rst_an(rst_an));
decrypt_round r4(.dec_round_in(w6), .dec_round_out(w7),.dec_round_key(key7),.select(select),.clk(clk),.rst_an(rst_an));
decrypt_round r5(.dec_round_in(w7), .dec_round_out(w8),.dec_round_key(key6),.select(select),.clk(clk),.rst_an(rst_an));
decrypt_round r6(.dec_round_in(w8), .dec_round_out(w9),.dec_round_key(key5),.select(select),.clk(clk),.rst_an(rst_an));
decrypt_round r7(.dec_round_in(w9), .dec_round_out(w10),.dec_round_key(key4),.select(select),.clk(clk),.rst_an(rst_an));
decrypt_round r8(.dec_round_in(w10), .dec_round_out(w11),.dec_round_key(key3),.select(select),.clk(clk),.rst_an(rst_an));
decrypt_round r9(.dec_round_in(w11), .dec_round_out(w12),.dec_round_key(key2),.select(select),.clk(clk),.rst_an(rst_an));

addroundkey r10(w12,key1,plain);

endmodule

module decrypttb;
reg [127:0]cipher;
wire [127:0]plain;
reg clk,rst_an,select;
decrypt d1(.cipher(cipher),.plain(plain),.clk(clk),.rst_an(rst_an),.select(select));

//initialization
initial
begin
clk=1'b0;
rst_an=1'b0;
#1 rst_an=1'b1;
select=1'b0;
//cipher=128'hedcbeac23fdaf5a51a3f1ae337481354;
//cipher = 128'hdfdadb7e0fd83825adf4dadee7ecc493;
//cipher = 128'hd99e8d3a2924256710ea2cce1e2233e8;
//cipher = 128'hbe1ff9c4694e2e53d6630c3289a82a37;
//cipher = 128'h0645fc1afa523baf667a5f7f5cc8ce4f;
//cipher = 128'h6c122f2bdf1fc6d9e39efe87fbf7cd12;
//cipher = 128'hcd12d82bf61fe3d9429e0987d2f7e812;
//cipher = 128'h735db53e656519d110652328f2e82a57;
//cipher = 128'hc5333095b969cb4b5042d99f865a8963;
cipher =128'h68a4b9aebdcf11fcf5dd6653952cbc46;
end always
#5 clk=~clk;

initial
# 200 $display("plain text =%h for cipher text = %h",plain,cipher);

initial
#220 $stop;

endmodule

