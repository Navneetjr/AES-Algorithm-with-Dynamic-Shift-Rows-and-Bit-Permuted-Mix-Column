module round(round_in, round_out,round_key,clk,rst_an,select);
input [127:0]round_in, round_key;
output [127:0]round_out;
wire [127:0]w1,w2,w3;
input clk,rst_an,select;

subBytes m3(.in(round_in),.out(w2),.clk(clk),.rst_an(rst_an),.select(select));
nov_shiftrow m4(.in(w2),.out(w3));
bit_perm m5(.in(w3),.out(w1));
addroundkey m6(.plaintext(w1),.key(round_key),.roundkey(round_out));

endmodule
