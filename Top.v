module encrypt(clk,rst_an,select,plaintext,ciphertext);
input clk,rst_an,select;
input [127:0]plaintext;
output [127:0]ciphertext;

wire [127:0]key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11;
wire [127:0]key111,key22,key33,key44,key55,key66,key77,key88,key99,key100,key110;
wire [127:0]w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12;                                                 //wires for interconnecting modules
wire [2047:0]sbox;
wire [127:0]initkey;

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
/*initial begin
#1;
$display("Key 1:%h",key1);
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
end
*/
//sboxgen m1(sbox,clk,rst_an,key11,key22,key33,key44,key55,key66,key77,key88,key99,key100,key110);
//sboxgen m1(sbox,clk,rst_an,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11);
addroundkey m2(plaintext,key1,w1);


round r1(.round_in(w1),.round_out(w2),.round_key(key2),.clk(clk),.rst_an(rst_an),.select(select));
round r2(.round_in(w2),.round_out(w3),.round_key(key3),.clk(clk),.rst_an(rst_an),.select(select));
round r3(.round_in(w3),.round_out(w4),.round_key(key4),.clk(clk),.rst_an(rst_an),.select(select));
round r4(.round_in(w4),.round_out(w5),.round_key(key5),.clk(clk),.rst_an(rst_an),.select(select));
round r5(.round_in(w5),.round_out(w6),.round_key(key6),.clk(clk),.rst_an(rst_an),.select(select));
round r6(.round_in(w6),.round_out(w7),.round_key(key7),.clk(clk),.rst_an(rst_an),.select(select));
round r7(.round_in(w7),.round_out(w8),.round_key(key8),.clk(clk),.rst_an(rst_an),.select(select));
round r8(.round_in(w8),.round_out(w9),.round_key(key9),.clk(clk),.rst_an(rst_an),.select(select));
round r9(.round_in(w9),.round_out(w10),.round_key(key10),.clk(clk),.rst_an(rst_an),.select(select));

subBytes s1(.in(w10),.clk(clk),.rst_an(rst_an),.select(select),.out(w11));
nov_shiftrow  s2(.in(w11),.out(w12));
addroundkey a1(.plaintext(w12),.key(key11),.roundkey(ciphertext));


endmodule

module encrypttb;

reg clk,rst_an,select;
reg [127:0]plaintext;
wire [127:0]ciphertext;
reg [127:0]x;
reg [8:0]count;
integer i;

encrypt DUT(clk,rst_an,select,plaintext,ciphertext);

initial begin
rst_an=1;
count = 0;
rst_an=0;
#1 rst_an=1;
clk=0;
#1 select =1'b1;
//#1 plaintext = 128'haabbccddeeff00112233445566778899;

#1 plaintext = 128'h11223344556677889900aabbccddeeff;
//#1 plaintext = 128'h655650f28d3c7df7b3fbb6422016c760;
//#1 plaintext = 128'h8e9b851d51d30edb3d7e4da8795a4f99;
//#1 plaintext = 128'hbaeaad9ea0518f8d07bd7f8a274c91ee;
//#1 plaintext = 128'h93e1b733d538872b5b700cf5030d7175;
//#1 plaintext = 128'h9533b9631f77f1de183feb7ad44e0a2a;
$monitor("Ciphertext:%h for PlainText:%h",ciphertext,plaintext);
#100;
x = (plaintext ^ ciphertext);
/*
for (i=0;i<128;i=i+1)
begin
    if(x[i]==1'b1)begin
    count=count+1;

    end
end
$display(count);
count=(count*100)/128;
$display("%f",count);
*/
end

always
#5 clk = ~clk;

endmodule