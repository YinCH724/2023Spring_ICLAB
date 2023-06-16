
module CC(
  in_s0,
  in_s1,
  in_s2,
  in_s3,
  in_s4,
  in_s5,
  in_s6,
  opt,
  a,
  b,
  s_id0,
  s_id1,
  s_id2,
  s_id3,
  s_id4,
  s_id5,
  s_id6,
  out

);
input [3:0]in_s0;
input [3:0]in_s1;
input [3:0]in_s2;
input [3:0]in_s3;
input [3:0]in_s4;
input [3:0]in_s5;
input [3:0]in_s6;
input [2:0]opt;
input [1:0]a;
input [2:0]b;
output [2:0] s_id0;
output [2:0] s_id1;
output [2:0] s_id2;
output [2:0] s_id3;
output [2:0] s_id4;
output [2:0] s_id5;
output [2:0] s_id6;
output [2:0] out; 
//==================================================================
// reg & wire
wire [2:0] sorted_s0;
wire [2:0] sorted_s1;
wire [2:0] sorted_s2;
wire [2:0] sorted_s3;
wire [2:0] sorted_s4;
wire [2:0] sorted_s5;
wire [2:0] sorted_s6;

wire [2:0] U_s_id0;
wire [2:0] U_s_id1;
wire [2:0] U_s_id2;
wire [2:0] U_s_id3;
wire [2:0] U_s_id4;
wire [2:0] U_s_id5;
wire [2:0] U_s_id6;

wire signed [2:0] S1_s_id0;
wire signed [2:0] S1_s_id1;
wire signed [2:0] S1_s_id2;
wire signed [2:0] S1_s_id3;
wire signed [2:0] S1_s_id4;
wire signed [2:0] S1_s_id5;
wire signed [2:0] S1_s_id6;

wire signed [2:0] S2_s_id0;
wire signed [2:0] S2_s_id1;
wire signed [2:0] S2_s_id2;
wire signed [2:0] S2_s_id3;
wire signed [2:0] S2_s_id4;
wire signed [2:0] S2_s_id5;
wire signed [2:0] S2_s_id6;

wire signed [2:0] S3_s_id0;
wire signed [2:0] S3_s_id1;
wire signed [2:0] S3_s_id2;
wire signed [2:0] S3_s_id3;
wire signed [2:0] S3_s_id4;
wire signed [2:0] S3_s_id5;
wire signed [2:0] S3_s_id6;

wire signed [2:0] S4_s_id0;
wire signed [2:0] S4_s_id1;
wire signed [2:0] S4_s_id2;
wire signed [2:0] S4_s_id3;
wire signed [2:0] S4_s_id4;
wire signed [2:0] S4_s_id5;
wire signed [2:0] S4_s_id6;

wire signed [2:0] S5_s_id0;
wire signed [2:0] S5_s_id1;
wire signed [2:0] S5_s_id2;
wire signed [2:0] S5_s_id3;
wire signed [2:0] S5_s_id4;
wire signed [2:0] S5_s_id5;
wire signed [2:0] S5_s_id6;

wire signed [2:0] S6_s_id0;
wire signed [2:0] S6_s_id1;
wire signed [2:0] S6_s_id2;
wire signed [2:0] S6_s_id3;
wire signed [2:0] S6_s_id4;
wire signed [2:0] S6_s_id5;
wire signed [2:0] S6_s_id6;

wire signed [2:0] S7_s_id0;
wire signed [2:0] S7_s_id1;
wire signed [2:0] S7_s_id2;
wire signed [2:0] S7_s_id3;
wire signed [2:0] S7_s_id4;
wire signed [2:0] S7_s_id5;
wire signed [2:0] S7_s_id6;

wire signed [4:0] Extand_S_in_s0;
wire signed [4:0] Extand_S_in_s1;
wire signed [4:0] Extand_S_in_s2;
wire signed [4:0] Extand_S_in_s3;
wire signed [4:0] Extand_S_in_s4;
wire signed [4:0] Extand_S_in_s5;
wire signed [4:0] Extand_S_in_s6;

wire signed [4:0] S_in_s0;
wire signed [4:0] S_in_s1;
wire signed [4:0] S_in_s2;
wire signed [4:0] S_in_s3;
wire signed [4:0] S_in_s4;
wire signed [4:0] S_in_s5;
wire signed [4:0] S_in_s6;

wire signed [4:0] S1_in_s0;
wire signed [4:0] S1_in_s1;
wire signed [4:0] S1_in_s2;
wire signed [4:0] S1_in_s3;
wire signed [4:0] S1_in_s4;
wire signed [4:0] S1_in_s5;
wire signed [4:0] S1_in_s6;

wire signed [4:0] S2_in_s0;
wire signed [4:0] S2_in_s1;
wire signed [4:0] S2_in_s2;
wire signed [4:0] S2_in_s3;
wire signed [4:0] S2_in_s4;
wire signed [4:0] S2_in_s5;
wire signed [4:0] S2_in_s6;

wire signed [4:0] S3_in_s0;
wire signed [4:0] S3_in_s1;
wire signed [4:0] S3_in_s2;
wire signed [4:0] S3_in_s3;
wire signed [4:0] S3_in_s4;
wire signed [4:0] S3_in_s5;
wire signed [4:0] S3_in_s6;

wire signed [4:0] S4_in_s0;
wire signed [4:0] S4_in_s1;
wire signed [4:0] S4_in_s2;
wire signed [4:0] S4_in_s3;
wire signed [4:0] S4_in_s4;
wire signed [4:0] S4_in_s5;
wire signed [4:0] S4_in_s6;

wire signed [4:0] S5_in_s0;
wire signed [4:0] S5_in_s1;
wire signed [4:0] S5_in_s2;
wire signed [4:0] S5_in_s3;
wire signed [4:0] S5_in_s4;
wire signed [4:0] S5_in_s5;
wire signed [4:0] S5_in_s6;

wire signed [4:0] S6_in_s0;
wire signed [4:0] S6_in_s1;
wire signed [4:0] S6_in_s2;
wire signed [4:0] S6_in_s3;
wire signed [4:0] S6_in_s4;
wire signed [4:0] S6_in_s5;
wire signed [4:0] S6_in_s6;

wire signed [4:0] S7_in_s0;
wire signed [4:0] S7_in_s1;
wire signed [4:0] S7_in_s2;
wire signed [4:0] S7_in_s3;
wire signed [4:0] S7_in_s4;
wire signed [4:0] S7_in_s5;
wire signed [4:0] S7_in_s6;

wire signed [5:0] S1p2;//1+2
wire signed [5:0] S3p4;//3+4
wire signed [5:0] S5p6;//5+6
wire signed [6:0] S00p12;
wire signed [6:0] S34p56;
wire signed [7:0] S_sum;
wire signed [4:0] S_Sdiv7;
wire signed [5:0] S_PassScore;

wire signed [8:0] S_Mu_s0;
wire signed [8:0] S_Mu_s1;
wire signed [8:0] S_Mu_s2;
wire signed [8:0] S_Mu_s3;
wire signed [8:0] S_Mu_s4;
wire signed [8:0] S_Mu_s5;
wire signed [8:0] S_Mu_s6;

wire [3:0] U_Ap1;
wire signed [3:0] S_Ap1;
wire signed [3:0] S_B;

wire signed [9:0] S_Linear_s0;
wire signed [9:0] S_Linear_s1;
wire signed [9:0] S_Linear_s2;
wire signed [9:0] S_Linear_s3;
wire signed [9:0] S_Linear_s4;
wire signed [9:0] S_Linear_s5;
wire signed [9:0] S_Linear_s6;

wire U_s0_pass;
wire U_s1_pass;
wire U_s2_pass;
wire U_s3_pass;
wire U_s4_pass;
wire U_s5_pass;
wire U_s6_pass;

wire S_s0_pass;
wire S_s1_pass;
wire S_s2_pass;
wire S_s3_pass;
wire S_s4_pass;
wire S_s5_pass;
wire S_s6_pass;

wire s0_pass;
wire s1_pass;
wire s2_pass;
wire s3_pass;
wire s4_pass;
wire s5_pass;
wire s6_pass;

wire [1:0] p_s0s1;
wire [1:0] p_s2s3;
wire [1:0] p_s4s5;

wire [2:0] p_s0s1ps2s3;
wire [2:0] p_s4s5ps6s6;

wire [3:0] pass_all;

wire signed [3:0] Signed7;

wire signed [8:0] S_Div_s0;
wire signed [8:0] S_Div_s1;
wire signed [8:0] S_Div_s2;
wire signed [8:0] S_Div_s3;
wire signed [8:0] S_Div_s4;
wire signed [8:0] S_Div_s5;
wire signed [8:0] S_Div_s6;

wire signed [3:0] zero_r;
wire signed [2:0] S_a;

//==================================================================


//==================================================================
// design
assign S_in_s0 = (opt[1] == 1'b1)? Extand_S_in_s0:Extand_S_in_s6;
assign S_in_s1 = (opt[1] == 1'b1)? Extand_S_in_s1:Extand_S_in_s5;
assign S_in_s2 = (opt[1] == 1'b1)? Extand_S_in_s2:Extand_S_in_s4;
assign S_in_s3 = (opt[1] == 1'b1)? Extand_S_in_s3:Extand_S_in_s3;
assign S_in_s4 = (opt[1] == 1'b1)? Extand_S_in_s4:Extand_S_in_s2;
assign S_in_s5 = (opt[1] == 1'b1)? Extand_S_in_s5:Extand_S_in_s1;
assign S_in_s6 = (opt[1] == 1'b1)? Extand_S_in_s6:Extand_S_in_s0;

assign Extand_S_in_s0 = (opt[0] == 1'b0)? {1'd0,in_s0}:{in_s0[3],in_s0};
assign Extand_S_in_s1 = (opt[0] == 1'b0)? {1'd0,in_s1}:{in_s1[3],in_s1};
assign Extand_S_in_s2 = (opt[0] == 1'b0)? {1'd0,in_s2}:{in_s2[3],in_s2};
assign Extand_S_in_s3 = (opt[0] == 1'b0)? {1'd0,in_s3}:{in_s3[3],in_s3};
assign Extand_S_in_s4 = (opt[0] == 1'b0)? {1'd0,in_s4}:{in_s4[3],in_s4};
assign Extand_S_in_s5 = (opt[0] == 1'b0)? {1'd0,in_s5}:{in_s5[3],in_s5};
assign Extand_S_in_s6 = (opt[0] == 1'b0)? {1'd0,in_s6}:{in_s6[3],in_s6};

assign U_s_id0 = (opt[1] == 1'b1)? 3'd0:3'd6;
assign U_s_id1 = (opt[1] == 1'b1)? 3'd1:3'd5;
assign U_s_id2 = (opt[1] == 1'b1)? 3'd2:3'd4;
assign U_s_id3 = (opt[1] == 1'b1)? 3'd3:3'd3;
assign U_s_id4 = (opt[1] == 1'b1)? 3'd4:3'd2;
assign U_s_id5 = (opt[1] == 1'b1)? 3'd5:3'd1;
assign U_s_id6 = (opt[1] == 1'b1)? 3'd6:3'd0;

assign S1p2 = S_in_s1 + S_in_s2;
assign S3p4 = S_in_s3 + S_in_s4;
assign S5p6 = S_in_s5 + S_in_s6;

assign S00p12 = S1p2 + S_in_s0;
assign S34p56 = S3p4 + S5p6;

assign S_sum = S00p12 + S34p56;

assign Signed7 = 4'd7;
assign S_Sdiv7 = S_sum/Signed7;

assign S_a = {1'd0,a};
assign S_PassScore = S_Sdiv7-S_a;
assign U_Ap1 = a + 2'b1;
assign S_Ap1 = {1'b0,U_Ap1};
assign S_B = {1'd0,b};

assign S_Div_s0 = S_in_s0/S_Ap1;
assign S_Div_s1 = S_in_s1/S_Ap1;
assign S_Div_s2 = S_in_s2/S_Ap1;
assign S_Div_s3 = S_in_s3/S_Ap1;
assign S_Div_s4 = S_in_s4/S_Ap1;
assign S_Div_s5 = S_in_s5/S_Ap1;
assign S_Div_s6 = S_in_s6/S_Ap1;

assign zero_r = 4'b0;
assign S_Mu_s0 = (S_in_s0<zero_r)? S_Div_s0:(S_in_s0*S_Ap1);
assign S_Mu_s1 = (S_in_s1<zero_r)? S_Div_s1:(S_in_s1*S_Ap1);
assign S_Mu_s2 = (S_in_s2<zero_r)? S_Div_s2:(S_in_s2*S_Ap1);
assign S_Mu_s3 = (S_in_s3<zero_r)? S_Div_s3:(S_in_s3*S_Ap1);
assign S_Mu_s4 = (S_in_s4<zero_r)? S_Div_s4:(S_in_s4*S_Ap1);
assign S_Mu_s5 = (S_in_s5<zero_r)? S_Div_s5:(S_in_s5*S_Ap1);
assign S_Mu_s6 = (S_in_s6<zero_r)? S_Div_s6:(S_in_s6*S_Ap1);

assign S_Linear_s0 = S_Mu_s0 + S_B;
assign S_Linear_s1 = S_Mu_s1 + S_B;
assign S_Linear_s2 = S_Mu_s2 + S_B;
assign S_Linear_s3 = S_Mu_s3 + S_B;
assign S_Linear_s4 = S_Mu_s4 + S_B;
assign S_Linear_s5 = S_Mu_s5 + S_B;
assign S_Linear_s6 = S_Mu_s6 + S_B;

assign S_s0_pass = (S_Linear_s0<S_PassScore)?1'b0:1'b1;
assign S_s1_pass = (S_Linear_s1<S_PassScore)?1'b0:1'b1;
assign S_s2_pass = (S_Linear_s2<S_PassScore)?1'b0:1'b1;
assign S_s3_pass = (S_Linear_s3<S_PassScore)?1'b0:1'b1;
assign S_s4_pass = (S_Linear_s4<S_PassScore)?1'b0:1'b1;
assign S_s5_pass = (S_Linear_s5<S_PassScore)?1'b0:1'b1;
assign S_s6_pass = (S_Linear_s6<S_PassScore)?1'b0:1'b1;

assign p_s0s1 = S_s0_pass + S_s1_pass;
assign p_s2s3 = S_s2_pass + S_s3_pass;
assign p_s4s5 = S_s4_pass + S_s5_pass;
assign p_s0s1ps2s3 = p_s0s1 + p_s2s3;
assign p_s4s5ps6s6 = p_s4s5 + S_s6_pass;
assign pass_all = p_s0s1ps2s3+p_s4s5ps6s6;

assign out = (opt[2] == 1'b0)? pass_all: (4'd7-pass_all);

assign s_id0 = (opt[1] == 1'b1)? S7_s_id0:S7_s_id6;
assign s_id1 = (opt[1] == 1'b1)? S7_s_id1:S7_s_id5;
assign s_id2 = (opt[1] == 1'b1)? S7_s_id2:S7_s_id4;
assign s_id3 = (opt[1] == 1'b1)? S7_s_id3:S7_s_id3;
assign s_id4 = (opt[1] == 1'b1)? S7_s_id4:S7_s_id2;
assign s_id5 = (opt[1] == 1'b1)? S7_s_id5:S7_s_id1;
assign s_id6 = (opt[1] == 1'b1)? S7_s_id6:S7_s_id0;

//

//signed
assign S1_in_s0 = (S_in_s0<S_in_s1)? S_in_s1:S_in_s0;
assign S1_in_s1 = (S_in_s0<S_in_s1)? S_in_s0:S_in_s1;
assign S1_s_id0 = (S_in_s0<S_in_s1)? U_s_id1:U_s_id0;
assign S1_s_id1 = (S_in_s0<S_in_s1)? U_s_id0:U_s_id1;

assign S1_in_s2 = (S_in_s2<S_in_s3)? S_in_s3:S_in_s2;
assign S1_in_s3 = (S_in_s2<S_in_s3)? S_in_s2:S_in_s3;
assign S1_s_id2 = (S_in_s2<S_in_s3)? U_s_id3:U_s_id2;
assign S1_s_id3 = (S_in_s2<S_in_s3)? U_s_id2:U_s_id3;

assign S1_in_s4 = (S_in_s4<S_in_s5)? S_in_s5:S_in_s4;
assign S1_in_s5 = (S_in_s4<S_in_s5)? S_in_s4:S_in_s5;
assign S1_s_id4 = (S_in_s4<S_in_s5)? U_s_id5:U_s_id4;
assign S1_s_id5 = (S_in_s4<S_in_s5)? U_s_id4:U_s_id5;

assign S1_in_s6 = S_in_s6;
assign S1_s_id6 = U_s_id6;


//S2
assign S2_in_s0 = S1_in_s0;
assign S2_s_id0 = S1_s_id0;

assign S2_in_s1 = (S1_in_s1<S1_in_s2)? S1_in_s2:S1_in_s1;
assign S2_in_s2 = (S1_in_s1<S1_in_s2)? S1_in_s1:S1_in_s2;
assign S2_s_id1 = (S1_in_s1<S1_in_s2)? S1_s_id2:S1_s_id1;
assign S2_s_id2 = (S1_in_s1<S1_in_s2)? S1_s_id1:S1_s_id2;

assign S2_in_s3 = (S1_in_s3<S1_in_s4)? S1_in_s4:S1_in_s3;
assign S2_in_s4 = (S1_in_s3<S1_in_s4)? S1_in_s3:S1_in_s4;
assign S2_s_id3 = (S1_in_s3<S1_in_s4)? S1_s_id4:S1_s_id3;
assign S2_s_id4 = (S1_in_s3<S1_in_s4)? S1_s_id3:S1_s_id4;

assign S2_in_s5 = (S1_in_s5<S1_in_s6)? S1_in_s6:S1_in_s5;
assign S2_in_s6 = (S1_in_s5<S1_in_s6)? S1_in_s5:S1_in_s6;
assign S2_s_id5 = (S1_in_s5<S1_in_s6)? S1_s_id6:S1_s_id5;
assign S2_s_id6 = (S1_in_s5<S1_in_s6)? S1_s_id5:S1_s_id6;

//S3
assign S3_in_s0 = (S2_in_s0<S2_in_s1)? S2_in_s1:S2_in_s0;
assign S3_in_s1 = (S2_in_s0<S2_in_s1)? S2_in_s0:S2_in_s1;
assign S3_s_id0 = (S2_in_s0<S2_in_s1)? S2_s_id1:S2_s_id0;
assign S3_s_id1 = (S2_in_s0<S2_in_s1)? S2_s_id0:S2_s_id1;

assign S3_in_s2 = (S2_in_s2<S2_in_s3)? S2_in_s3:S2_in_s2;
assign S3_in_s3 = (S2_in_s2<S2_in_s3)? S2_in_s2:S2_in_s3;
assign S3_s_id2 = (S2_in_s2<S2_in_s3)? S2_s_id3:S2_s_id2;
assign S3_s_id3 = (S2_in_s2<S2_in_s3)? S2_s_id2:S2_s_id3;

assign S3_in_s4 = (S2_in_s4<S2_in_s5)? S2_in_s5:S2_in_s4;
assign S3_in_s5 = (S2_in_s4<S2_in_s5)? S2_in_s4:S2_in_s5;
assign S3_s_id4 = (S2_in_s4<S2_in_s5)? S2_s_id5:S2_s_id4;
assign S3_s_id5 = (S2_in_s4<S2_in_s5)? S2_s_id4:S2_s_id5;

assign S3_in_s6 = S2_in_s6;
assign S3_s_id6 = S2_s_id6;

//S4
assign S4_in_s0 = S3_in_s0;
assign S4_s_id0 = S3_s_id0;

assign S4_in_s1 = (S3_in_s1<S3_in_s2)? S3_in_s2:S3_in_s1;
assign S4_in_s2 = (S3_in_s1<S3_in_s2)? S3_in_s1:S3_in_s2;
assign S4_s_id1 = (S3_in_s1<S3_in_s2)? S3_s_id2:S3_s_id1;
assign S4_s_id2 = (S3_in_s1<S3_in_s2)? S3_s_id1:S3_s_id2;

assign S4_in_s3 = (S3_in_s3<S3_in_s4)? S3_in_s4:S3_in_s3;
assign S4_in_s4 = (S3_in_s3<S3_in_s4)? S3_in_s3:S3_in_s4;
assign S4_s_id3 = (S3_in_s3<S3_in_s4)? S3_s_id4:S3_s_id3;
assign S4_s_id4 = (S3_in_s3<S3_in_s4)? S3_s_id3:S3_s_id4;

assign S4_in_s5 = (S3_in_s5<S3_in_s6)? S3_in_s6:S3_in_s5;
assign S4_in_s6 = (S3_in_s5<S3_in_s6)? S3_in_s5:S3_in_s6;
assign S4_s_id5 = (S3_in_s5<S3_in_s6)? S3_s_id6:S3_s_id5;
assign S4_s_id6 = (S3_in_s5<S3_in_s6)? S3_s_id5:S3_s_id6;


//S5
assign S5_in_s0 = (S4_in_s0<S4_in_s1)? S4_in_s1:S4_in_s0;
assign S5_in_s1 = (S4_in_s0<S4_in_s1)? S4_in_s0:S4_in_s1;
assign S5_s_id0 = (S4_in_s0<S4_in_s1)? S4_s_id1:S4_s_id0;
assign S5_s_id1 = (S4_in_s0<S4_in_s1)? S4_s_id0:S4_s_id1;

assign S5_in_s2 = (S4_in_s2<S4_in_s3)? S4_in_s3:S4_in_s2;
assign S5_in_s3 = (S4_in_s2<S4_in_s3)? S4_in_s2:S4_in_s3;
assign S5_s_id2 = (S4_in_s2<S4_in_s3)? S4_s_id3:S4_s_id2;
assign S5_s_id3 = (S4_in_s2<S4_in_s3)? S4_s_id2:S4_s_id3;

assign S5_in_s4 = (S4_in_s4<S4_in_s5)? S4_in_s5:S4_in_s4;
assign S5_in_s5 = (S4_in_s4<S4_in_s5)? S4_in_s4:S4_in_s5;
assign S5_s_id4 = (S4_in_s4<S4_in_s5)? S4_s_id5:S4_s_id4;
assign S5_s_id5 = (S4_in_s4<S4_in_s5)? S4_s_id4:S4_s_id5;

assign S5_in_s6 = S4_in_s6;
assign S5_s_id6 = S4_s_id6;

//S6
assign S6_in_s0 = S5_in_s0;
assign S6_s_id0 = S5_s_id0;

assign S6_in_s1 = (S5_in_s1<S5_in_s2)? S5_in_s2:S5_in_s1;
assign S6_in_s2 = (S5_in_s1<S5_in_s2)? S5_in_s1:S5_in_s2;
assign S6_s_id1 = (S5_in_s1<S5_in_s2)? S5_s_id2:S5_s_id1;
assign S6_s_id2 = (S5_in_s1<S5_in_s2)? S5_s_id1:S5_s_id2;

assign S6_in_s3 = (S5_in_s3<S5_in_s4)? S5_in_s4:S5_in_s3;
assign S6_in_s4 = (S5_in_s3<S5_in_s4)? S5_in_s3:S5_in_s4;
assign S6_s_id3 = (S5_in_s3<S5_in_s4)? S5_s_id4:S5_s_id3;
assign S6_s_id4 = (S5_in_s3<S5_in_s4)? S5_s_id3:S5_s_id4;

assign S6_in_s5 = (S5_in_s5<S5_in_s6)? S5_in_s6:S5_in_s5;
assign S6_in_s6 = (S5_in_s5<S5_in_s6)? S5_in_s5:S5_in_s6;
assign S6_s_id5 = (S5_in_s5<S5_in_s6)? S5_s_id6:S5_s_id5;
assign S6_s_id6 = (S5_in_s5<S5_in_s6)? S5_s_id5:S5_s_id6;

//S7
assign S7_s_id0 = (S6_in_s0<S6_in_s1)? S6_s_id1:S6_s_id0;
assign S7_s_id1 = (S6_in_s0<S6_in_s1)? S6_s_id0:S6_s_id1;

assign S7_s_id2 = (S6_in_s2<S6_in_s3)? S6_s_id3:S6_s_id2;
assign S7_s_id3 = (S6_in_s2<S6_in_s3)? S6_s_id2:S6_s_id3;

assign S7_s_id4 = (S6_in_s4<S6_in_s5)? S6_s_id5:S6_s_id4;
assign S7_s_id5 = (S6_in_s4<S6_in_s5)? S6_s_id4:S6_s_id5;

assign S7_s_id6 = S6_s_id6;

//==================================================================

endmodule
