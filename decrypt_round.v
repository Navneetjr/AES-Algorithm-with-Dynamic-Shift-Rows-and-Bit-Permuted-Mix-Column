module decrypt_round(dec_round_in, dec_round_out,dec_round_key,select,clk,rst_an);
input [127:0]dec_round_in, dec_round_key;
output [127:0]dec_round_out;
wire [127:0]w1,w2,w3;
input clk,rst_an,select;

addroundkey a1(.plaintext(dec_round_in),.key(dec_round_key),.roundkey(w1));
inverse_bit_perm b1(.in(w1),.out(w2));
nov_inv_shiftrow c1(.in(w2),.out(w3));
subBytes sb1(w3,dec_round_out,clk,rst_an,select);

endmodule