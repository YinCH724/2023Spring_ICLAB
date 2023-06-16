module QUEEN(
    //Input Port
    clk,
    rst_n,

    in_valid,
    col,
    row,

    in_valid_num,
    in_num,

    out_valid,
    out,

    );

input               clk, rst_n, in_valid,in_valid_num;
input       [3:0]   col,row;
input       [2:0]   in_num;

output reg          out_valid;
output reg  [3:0]   out;

//==============================================//
//             Parameter and Integer            //
//==============================================//
parameter s_idle = 3'd0;
parameter s_input = 3'd1;
parameter s_cul = 3'd2;
parameter s_output = 3'd3;
parameter s_rst = 3'd4;

genvar NN;
genvar MM;
integer i;
wire [3:0] Row [11:0];
wire [3:0] Col [11:0];
wire [4:0] slash1[11:0][11:0];
wire [4:0] slash2[11:0][11:0];


assign Row[0] = 4'd0;
assign Row[1] = 4'd1;
assign Row[2] = 4'd2;
assign Row[3] = 4'd3;
assign Row[4] = 4'd4;
assign Row[5] = 4'd5;
assign Row[6] = 4'd6;
assign Row[7] = 4'd7;
assign Row[8] = 4'd8;
assign Row[9] = 4'd9;
assign Row[10] = 4'd10;
assign Row[11] = 4'd11;

assign Col[0] = 4'd0;
assign Col[1] = 4'd1;
assign Col[2] = 4'd2;
assign Col[3] = 4'd3;
assign Col[4] = 4'd4;
assign Col[5] = 4'd5;
assign Col[6] = 4'd6;
assign Col[7] = 4'd7;
assign Col[8] = 4'd8;
assign Col[9] = 4'd9;
assign Col[10] = 4'd10;
assign Col[11] = 4'd11;

assign slash1[0][0] = 5'd0;

assign slash1[0][1] = 5'd1;
assign slash1[1][0] = 5'd1;

assign slash1[0][2] = 5'd2;
assign slash1[1][1] = 5'd2;
assign slash1[2][0] = 5'd2;

assign slash1[0][3] = 5'd3;
assign slash1[2][1] = 5'd3;
assign slash1[1][2] = 5'd3;
assign slash1[3][0] = 5'd3;

assign slash1[0][4] = 5'd4;
assign slash1[1][3] = 5'd4;
assign slash1[2][2] = 5'd4;
assign slash1[3][1] = 5'd4;
assign slash1[4][0] = 5'd4;

assign slash1[0][5] = 5'd5;
assign slash1[1][4] = 5'd5;
assign slash1[2][3] = 5'd5;
assign slash1[3][2] = 5'd5;
assign slash1[4][1] = 5'd5;
assign slash1[5][0] = 5'd5;

assign slash1[0][6] = 5'd6;
assign slash1[1][5] = 5'd6;
assign slash1[2][4] = 5'd6;
assign slash1[3][3] = 5'd6;
assign slash1[4][2] = 5'd6;
assign slash1[5][1] = 5'd6;
assign slash1[6][0] = 5'd6;

assign slash1[0][7] = 5'd7;
assign slash1[1][6] = 5'd7;
assign slash1[2][5] = 5'd7;
assign slash1[3][4] = 5'd7;
assign slash1[4][3] = 5'd7;
assign slash1[5][2] = 5'd7;
assign slash1[6][1] = 5'd7;
assign slash1[7][0] = 5'd7;

assign slash1[0][8] = 5'd8;
assign slash1[1][7] = 5'd8;
assign slash1[2][6] = 5'd8;
assign slash1[3][5] = 5'd8;
assign slash1[4][4] = 5'd8;
assign slash1[5][3] = 5'd8;
assign slash1[6][2] = 5'd8;
assign slash1[7][1] = 5'd8;
assign slash1[8][0] = 5'd8;

assign slash1[0][9] = 5'd9;
assign slash1[1][8] = 5'd9;
assign slash1[2][7] = 5'd9;
assign slash1[3][6] = 5'd9;
assign slash1[4][5] = 5'd9;
assign slash1[5][4] = 5'd9;
assign slash1[6][3] = 5'd9;
assign slash1[7][2] = 5'd9;
assign slash1[8][1] = 5'd9;
assign slash1[9][0] = 5'd9;

assign slash1[0][10] = 5'd10;
assign slash1[1][9] = 5'd10;
assign slash1[2][8] = 5'd10;
assign slash1[3][7] = 5'd10;
assign slash1[4][6] = 5'd10;
assign slash1[5][5] = 5'd10;
assign slash1[6][4] = 5'd10;
assign slash1[7][3] = 5'd10;
assign slash1[8][2] = 5'd10;
assign slash1[9][1] = 5'd10;
assign slash1[10][0] = 5'd10;

assign slash1[0][11] = 5'd11;
assign slash1[1][10] = 5'd11;
assign slash1[2][9] = 5'd11;
assign slash1[3][8] = 5'd11;
assign slash1[4][7] = 5'd11;
assign slash1[5][6] = 5'd11;
assign slash1[6][5] = 5'd11;
assign slash1[7][4] = 5'd11;
assign slash1[8][3] = 5'd11;
assign slash1[9][2] = 5'd11;
assign slash1[10][1] = 5'd11;
assign slash1[11][0] = 5'd11;

assign slash1[1][11] = 5'd12;
assign slash1[2][10] = 5'd12;
assign slash1[3][9] = 5'd12;
assign slash1[4][8] = 5'd12;
assign slash1[5][7] = 5'd12;
assign slash1[6][6] = 5'd12;
assign slash1[7][5] = 5'd12;
assign slash1[8][4] = 5'd12;
assign slash1[9][3] = 5'd12;
assign slash1[10][2] = 5'd12;
assign slash1[11][1] = 5'd12;

assign slash1[2][11] = 5'd13;
assign slash1[3][10] = 5'd13;
assign slash1[4][9] = 5'd13;
assign slash1[5][8] = 5'd13;
assign slash1[6][7] = 5'd13;
assign slash1[7][6] = 5'd13;
assign slash1[8][5] = 5'd13;
assign slash1[9][4] = 5'd13;
assign slash1[10][3] = 5'd13;
assign slash1[11][2] = 5'd13;

assign slash1[3][11] = 5'd14;
assign slash1[4][10] = 5'd14;
assign slash1[5][9] = 5'd14;
assign slash1[6][8] = 5'd14;
assign slash1[7][7] = 5'd14;
assign slash1[8][6] = 5'd14;
assign slash1[9][5] = 5'd14;
assign slash1[10][4] = 5'd14;
assign slash1[11][3] = 5'd14;

assign slash1[4][11] = 5'd15;
assign slash1[5][10] = 5'd15;
assign slash1[6][9] = 5'd15;
assign slash1[7][8] = 5'd15;
assign slash1[8][7] = 5'd15;
assign slash1[9][6] = 5'd15;
assign slash1[10][5] = 5'd15;
assign slash1[11][4] = 5'd15;

assign slash1[5][11] = 5'd16;
assign slash1[6][10] = 5'd16;
assign slash1[7][9] = 5'd16;
assign slash1[8][8] = 5'd16;
assign slash1[9][7] = 5'd16;
assign slash1[10][6] = 5'd16;
assign slash1[11][5] = 5'd16;

assign slash1[6][11] = 5'd17;
assign slash1[7][10] = 5'd17;
assign slash1[8][9] = 5'd17;
assign slash1[9][8] = 5'd17;
assign slash1[10][7] = 5'd17;
assign slash1[11][6] = 5'd17;

assign slash1[7][11] = 5'd18;
assign slash1[8][10] = 5'd18;
assign slash1[9][9] = 5'd18;
assign slash1[10][8] = 5'd18;
assign slash1[11][7] = 5'd18;

assign slash1[8][11] = 5'd19;
assign slash1[9][10] = 5'd19;
assign slash1[10][9] = 5'd19;
assign slash1[11][8] = 5'd19;

assign slash1[9][11] = 5'd20;
assign slash1[10][10] = 5'd20;
assign slash1[11][9] = 5'd20;

assign slash1[10][11] = 5'd21;
assign slash1[11][10] = 5'd21;

assign slash1[11][11] = 5'd22;



//slash2
assign slash2[0][11] = 5'd0;

assign slash2[0][10] = 5'd1;
assign slash2[1][11] = 5'd1;

assign slash2[0][9] = 5'd2;
assign slash2[1][10] = 5'd2;
assign slash2[2][11] = 5'd2;

assign slash2[0][8] = 5'd3;
assign slash2[1][9] = 5'd3;
assign slash2[2][10] = 5'd3;
assign slash2[3][11] = 5'd3;

assign slash2[0][7] = 5'd4;
assign slash2[1][8] = 5'd4;
assign slash2[2][9] = 5'd4;
assign slash2[3][10] = 5'd4;
assign slash2[4][11] = 5'd4;

assign slash2[0][6] = 5'd5;
assign slash2[1][7] = 5'd5;
assign slash2[2][8] = 5'd5;
assign slash2[3][9] = 5'd5;
assign slash2[4][10] = 5'd5;
assign slash2[5][11] = 5'd5;

assign slash2[0][5] = 5'd6;
assign slash2[1][6] = 5'd6;
assign slash2[2][7] = 5'd6;
assign slash2[3][8] = 5'd6;
assign slash2[4][9] = 5'd6;
assign slash2[5][10] = 5'd6;
assign slash2[6][11] = 5'd6;

assign slash2[0][4] = 5'd7;
assign slash2[1][5] = 5'd7;
assign slash2[2][6] = 5'd7;
assign slash2[3][7] = 5'd7;
assign slash2[4][8] = 5'd7;
assign slash2[5][9] = 5'd7;
assign slash2[6][10] = 5'd7;
assign slash2[7][11] = 5'd7;

assign slash2[0][3] = 5'd8;
assign slash2[1][4] = 5'd8;
assign slash2[2][5] = 5'd8;
assign slash2[3][6] = 5'd8;
assign slash2[4][7] = 5'd8;
assign slash2[5][8] = 5'd8;
assign slash2[6][9] = 5'd8;
assign slash2[7][10] = 5'd8;
assign slash2[8][11] = 5'd8;

assign slash2[0][2] = 5'd9;
assign slash2[1][3] = 5'd9;
assign slash2[2][4] = 5'd9;
assign slash2[3][5] = 5'd9;
assign slash2[4][6] = 5'd9;
assign slash2[5][7] = 5'd9;
assign slash2[6][8] = 5'd9;
assign slash2[7][9] = 5'd9;
assign slash2[8][10] = 5'd9;
assign slash2[9][11] = 5'd9;

assign slash2[0][1] = 5'd10;
assign slash2[1][2] = 5'd10;
assign slash2[2][3] = 5'd10;
assign slash2[3][4] = 5'd10;
assign slash2[4][5] = 5'd10;
assign slash2[5][6] = 5'd10;
assign slash2[6][7] = 5'd10;
assign slash2[7][8] = 5'd10;
assign slash2[8][9] = 5'd10;
assign slash2[9][10] = 5'd10;
assign slash2[10][11] = 5'd10;

assign slash2[0][0] = 5'd11;
assign slash2[1][1] = 5'd11;
assign slash2[2][2] = 5'd11;
assign slash2[3][3] = 5'd11;
assign slash2[4][4] = 5'd11;
assign slash2[5][5] = 5'd11;
assign slash2[6][6] = 5'd11;
assign slash2[7][7] = 5'd11;
assign slash2[8][8] = 5'd11;
assign slash2[9][9] = 5'd11;
assign slash2[10][10] = 5'd11;
assign slash2[11][11] = 5'd11;

assign slash2[1][0] = 5'd12;
assign slash2[2][1] = 5'd12;
assign slash2[3][2] = 5'd12;
assign slash2[4][3] = 5'd12;
assign slash2[5][4] = 5'd12;
assign slash2[6][5] = 5'd12;
assign slash2[7][6] = 5'd12;
assign slash2[8][7] = 5'd12;
assign slash2[9][8] = 5'd12;
assign slash2[10][9] = 5'd12;
assign slash2[11][10] = 5'd12;

assign slash2[2][0] = 5'd13;
assign slash2[3][1] = 5'd13;
assign slash2[4][2] = 5'd13;
assign slash2[5][3] = 5'd13;
assign slash2[6][4] = 5'd13;
assign slash2[7][5] = 5'd13;
assign slash2[8][6] = 5'd13;
assign slash2[9][7] = 5'd13;
assign slash2[10][8] = 5'd13;
assign slash2[11][9] = 5'd13;

assign slash2[3][0] = 5'd14;
assign slash2[4][1] = 5'd14;
assign slash2[5][2] = 5'd14;
assign slash2[6][3] = 5'd14;
assign slash2[7][4] = 5'd14;
assign slash2[8][5] = 5'd14;
assign slash2[9][6] = 5'd14;
assign slash2[10][7] = 5'd14;
assign slash2[11][8] = 5'd14;

assign slash2[4][0] = 5'd15;
assign slash2[5][1] = 5'd15;
assign slash2[6][2] = 5'd15;
assign slash2[7][3] = 5'd15;
assign slash2[8][4] = 5'd15;
assign slash2[9][5] = 5'd15;
assign slash2[10][6] = 5'd15;
assign slash2[11][7] = 5'd15;

assign slash2[5][0] = 5'd16;
assign slash2[6][1] = 5'd16;
assign slash2[7][2] = 5'd16;
assign slash2[8][3] = 5'd16;
assign slash2[9][4] = 5'd16;
assign slash2[10][5] = 5'd16;
assign slash2[11][6] = 5'd16;

assign slash2[6][0] = 5'd17;
assign slash2[7][1] = 5'd17;
assign slash2[8][2] = 5'd17;
assign slash2[9][3] = 5'd17;
assign slash2[10][4] = 5'd17;
assign slash2[11][5] = 5'd17;

assign slash2[7][0] = 5'd18;
assign slash2[8][1] = 5'd18;
assign slash2[9][2] = 5'd18;
assign slash2[10][3] = 5'd18;
assign slash2[11][4] = 5'd18;

assign slash2[8][0] = 5'd19;
assign slash2[9][1] = 5'd19;
assign slash2[10][2] = 5'd19;
assign slash2[11][3] = 5'd19;

assign slash2[9][0] = 5'd20;
assign slash2[10][1] = 5'd20;
assign slash2[11][2] = 5'd20;

assign slash2[10][0] = 5'd21;
assign slash2[11][1] = 5'd21;

assign slash2[11][0] = 5'd22;


//==============================================//
//                 reg declaration              //
//==============================================//
reg [2:0] R_in_num;
reg [3:0] cnt; 

reg [3:0] Col_In [5:0];


reg [3:0] Row_In [5:0];

reg [3:0] Col_out[11:0];

reg [2:0] current_state;
reg [2:0] next_state;
wire able_[11:0][11:0];
reg [3:0]c_sel[11:0];
reg [4:0]slash1_sel[11:0];
reg [4:0]slash2_sel[11:0];
wire slash1_check_In_1[11:0][11:0];
wire slash1_check_In_2[11:0][11:0];
wire slash1_check_In_3[11:0][11:0];
wire slash1_check_In_4[11:0][11:0];
wire slash1_check_In_5[11:0][11:0];
wire slash1_check_In_6[11:0][11:0];
wire slash1_check_In[11:0][11:0];
wire slash1_check[11:0][11:0];

wire slash2_check_In_1[11:0][11:0];
wire slash2_check_In_2[11:0][11:0];
wire slash2_check_In_3[11:0][11:0];
wire slash2_check_In_4[11:0][11:0];
wire slash2_check_In_5[11:0][11:0];
wire slash2_check_In_6[11:0][11:0];
wire slash2_check_In[11:0][11:0];
wire slash2_check[11:0][11:0];

wire Mask_able[11:0][11:0];
wire stage1_able[11:0][10:0];
wire stage2_able[11:0][9:0];
wire stage3_able[11:0][8:0];
wire stage4_able[11:0][7:0];
wire stage5_able[11:0][6:0];
wire stage6_able[11:0][5:0];
wire stage7_able[11:0][4:0];
wire stage8_able[11:0][3:0];
wire stage9_able[11:0][2:0];
wire stage10_able[11:0][1:0];
wire stage11_able[11:0];
wire [3:0]c_ans[11:0];

wire able_1_slash1[11:0][10:0];
wire able_2_slash1[11:0][9:0];
wire able_3_slash1[11:0][8:0];
wire able_4_slash1[11:0][7:0];
wire able_5_slash1[11:0][6:0];
wire able_6_slash1[11:0][5:0];
wire able_7_slash1[11:0][4:0];
wire able_8_slash1[11:0][3:0];
wire able_9_slash1[11:0][2:0];
wire able_10_slash1[11:0][1:0];
wire able_11_slash1[11:0];
wire able_1_slash2[11:0][10:0];
wire able_2_slash2[11:0][9:0];
wire able_3_slash2[11:0][8:0];
wire able_4_slash2[11:0][7:0];
wire able_5_slash2[11:0][6:0];
wire able_6_slash2[11:0][5:0];
wire able_7_slash2[11:0][4:0];
wire able_8_slash2[11:0][3:0];
wire able_9_slash2[11:0][2:0];
wire able_10_slash2[11:0][1:0];
wire able_11_slash2[11:0];
wire able_row1[11:0][10:0];
wire able_row2[11:0][9:0];
wire able_row3[11:0][8:0];
wire able_row4[11:0][7:0];
wire able_row5[11:0][6:0];
wire able_row6[11:0][5:0];
wire able_row7[11:0][4:0];
wire able_row8[11:0][3:0];
wire able_row9[11:0][2:0];
wire able_row10[11:0][1:0];
wire able_row11[11:0];

wire [4:0] slash1_In[5:0];
wire [4:0] slash2_In[5:0];

wire r_in1[11:0];
wire r_in2[11:0];
wire r_in3[11:0];
wire r_in4[11:0];
wire r_in5[11:0];
wire r_in6[11:0];

wire c_in1[11:0];
wire c_in2[11:0];
wire c_in3[11:0];
wire c_in4[11:0];
wire c_in5[11:0];
wire c_in6[11:0];

wire r[11:0];
wire c[11:0];
wire [3:0]c_In[11:0];

reg [3:0]col_line[11:0];
reg [3:0]change_col;

reg [3:0]col_sel;

wire [4:0]s1_In[11:0];
wire [4:0]s2_In[11:0];
wire [4:0]s1_ans[11:0];
wire [4:0]s2_ans[11:0];

reg  [4:0]slash1_Ans_reg[11:0];
reg  [4:0]slash2_Ans_reg[11:0];
reg  [3:0]c_Ans_reg[11:0];

reg [3:0]row_sel[11:0];

reg [3:0]r_row_sel[11:0];
reg able_reg[11:0][11:0];

reg next_forword;
reg forword;

reg [11:0]loc_mask[11:0];

wire r_stage0[11:0];
wire slash1_check_stage0[11:0][10:0];
wire slash2_check_stage0[11:0][10:0];
wire col1_map[11:0][10:0];
reg able_reg1[11:0][10:0];

wire r_stage1[11:0];
wire slash1_check_stage1[11:0][9:0];
wire slash2_check_stage1[11:0][9:0];
wire col2_map[11:0][9:0];
reg able_reg2[11:0][9:0];

wire r_stage2[11:0];
wire slash1_check_stage2[11:0][8:0];
wire slash2_check_stage2[11:0][8:0];
wire col3_map[11:0][8:0];
reg able_reg3[11:0][8:0];

wire r_stage3[11:0];
wire slash1_check_stage3[11:0][7:0];
wire slash2_check_stage3[11:0][7:0];
wire col4_map[11:0][7:0];
reg able_reg4[11:0][7:0];

wire r_stage4[11:0];
wire slash1_check_stage4[11:0][6:0];
wire slash2_check_stage4[11:0][6:0];
wire col5_map[11:0][6:0];
reg able_reg5[11:0][6:0];

wire r_stage5[11:0];
wire slash1_check_stage5[11:0][5:0];
wire slash2_check_stage5[11:0][5:0];
wire col6_map[11:0][5:0];
reg able_reg6[11:0][5:0];

wire r_stage6[11:0];
wire slash1_check_stage6[11:0][4:0];
wire slash2_check_stage6[11:0][4:0];
wire col7_map[11:0][4:0];
reg able_reg7[11:0][4:0];

wire r_stage7[11:0];
wire slash1_check_stage7[11:0][3:0];
wire slash2_check_stage7[11:0][3:0];
wire col8_map[11:0][3:0];
reg able_reg8[11:0][3:0];

wire r_stage8[11:0];
wire slash1_check_stage8[11:0][2:0];
wire slash2_check_stage8[11:0][2:0];
wire col9_map[11:0][2:0];
reg able_reg9[11:0][2:0];

wire r_stage9[11:0];
wire slash1_check_stage9[11:0][1:0];
wire slash2_check_stage9[11:0][1:0];
wire col10_map[11:0][1:0];
reg able_reg10[11:0][1:0];

wire r_stage10[11:0];
wire slash1_check_stage10[11:0][0:0];
wire slash2_check_stage10[11:0][0:0];
wire col11_map[11:0][0:0];
reg able_reg11[11:0][0:0];

reg [3:0]next_col_sel;
reg in_rst;

wire [11:0]col_mask[11:0];
wire [2:0]check[11:0];
wire [11:0]Select_Mask[11:0];
wire T_S_L[11:0][11:0];
wire T_Select_Mask[11:0][11:0];

//==============================================//
//            FSM State Declaration             //
//==============================================//
//current_state
reg [15:0]spcnt;
//next_state
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
        current_state <= s_idle;
    else
        current_state <= next_state;
end
always@(*)begin
	case(current_state)
		s_idle: if(in_valid) next_state = s_input;
				else next_state = s_idle;
				
		s_input:if (cnt == R_in_num) next_state = s_cul;
				else next_state = s_input;
		
		s_cul: if (col_sel == 4'd12) next_state = s_output;
				else next_state = s_cul;
				
		s_output:if (cnt == 4'd12) next_state = s_idle;
				else next_state = s_output;
				/*
		s_rst:if (cnt == 4'd1) next_state = s_idle;
				else next_state = s_rst;
				*/
		
		default: next_state = current_state;
		
	endcase 
end
/*
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
        spcnt <= 4'b0;
    else
		case(current_state)
			s_idle: spcnt <= 4'd0;
			s_cul: if (spcnt == 16'd1500) spcnt <= 4'd0;
					else spcnt <= spcnt + 4'd1;
			default: spcnt <= spcnt;
		endcase
end
*/
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
        cnt <= 4'b0;
    else
		case(current_state)
			s_idle: cnt <= 4'd0;
			s_input: if(cnt == R_in_num) cnt <= 4'd0;
					else cnt <= cnt + 4'd1;
			s_cul:cnt <= 4'd0;

			s_output: if (cnt == 4'd12) cnt <= 4'd0;
					else cnt <= cnt + 4'd1;
			default: cnt <= cnt;
		endcase
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
        in_rst <= 1'b1;
    else
		case(current_state)
			s_idle: in_rst <= 4'd1;
			s_output: if (cnt == 4'd12) in_rst<= 1'd0;
					else in_rst<= 1'd1;			
			default: in_rst <= 4'd1;
		endcase
end

//==============================================//
//                  Input Block                 //
//==============================================//
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        R_in_num <= 3'b0;
    else
		case(current_state)
			s_idle: if(in_valid_num) R_in_num <= in_num;
					else R_in_num <= R_in_num;
			default: R_in_num <= R_in_num;
		endcase
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n )begin
        Col_In[0] <= 4'd15;
        Col_In[1] <= 4'd15;
        Col_In[2] <= 4'd15;
        Col_In[3] <= 4'd15;
		Col_In[4] <= 4'd15;
		Col_In[5] <= 4'd15;
    end
	else if (!in_rst) begin
		Col_In[0] <= 4'd15;
        Col_In[1] <= 4'd15;
        Col_In[2] <= 4'd15;
        Col_In[3] <= 4'd15;
		Col_In[4] <= 4'd15;
		Col_In[5] <= 4'd15;
	end
    else
		case(current_state)
			s_idle: if(in_valid)begin
						Col_In[0] <= col;
						Col_In[1] <= Col_In[0];
						Col_In[2] <= Col_In[1];
						Col_In[3] <= Col_In[2];
						Col_In[4] <= Col_In[3];
						Col_In[5] <= Col_In[4];
					end
					else begin 
						Col_In[0] <= Col_In[0];
						Col_In[1] <= Col_In[1];
						Col_In[2] <= Col_In[2];
						Col_In[3] <= Col_In[3];
						Col_In[4] <= Col_In[4];
						Col_In[5] <= Col_In[5];
					end
			s_input:if(in_valid)begin
						Col_In[0] <= col;
						Col_In[1] <= Col_In[0];
						Col_In[2] <= Col_In[1];
						Col_In[3] <= Col_In[2];
						Col_In[4] <= Col_In[3];
						Col_In[5] <= Col_In[4];
					end
					else begin 
						Col_In[0] <= Col_In[0];
						Col_In[1] <= Col_In[1];
						Col_In[2] <= Col_In[2];
						Col_In[3] <= Col_In[3];
						Col_In[4] <= Col_In[4];
						Col_In[5] <= Col_In[5];
					end
			default: begin 
						Col_In[0] <= Col_In[0];
						Col_In[1] <= Col_In[1];
						Col_In[2] <= Col_In[2];
						Col_In[3] <= Col_In[3];
						Col_In[4] <= Col_In[4];
						Col_In[5] <= Col_In[5];
					end
		endcase
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        Row_In[0] <= 4'd15;
        Row_In[1] <= 4'd15;
        Row_In[2] <= 4'd15;
        Row_In[3] <= 4'd15;
		Row_In[4] <= 4'd15;
		Row_In[5] <= 4'd15;
    end   
	else if (!in_rst)begin
		Row_In[0] <= 4'd15;
        Row_In[1] <= 4'd15;
        Row_In[2] <= 4'd15;
        Row_In[3] <= 4'd15;
		Row_In[4] <= 4'd15;
		Row_In[5] <= 4'd15;
	end
    else
		case(current_state)
			s_idle: if(in_valid)begin
						Row_In[0] <= row;
						Row_In[1] <= Row_In[0];
						Row_In[2] <= Row_In[1];
						Row_In[3] <= Row_In[2];
						Row_In[4] <= Row_In[3];
						Row_In[5] <= Row_In[4];
					end
					else begin 
						Row_In[0] <= Row_In[0];
						Row_In[1] <= Row_In[1];
						Row_In[2] <= Row_In[2];
						Row_In[3] <= Row_In[3];
						Row_In[4] <= Row_In[4];
						Row_In[5] <= Row_In[5];
					end
			s_input:if(in_valid)begin
						Row_In[0] <= row;
						Row_In[1] <= Row_In[0];
						Row_In[2] <= Row_In[1];
						Row_In[3] <= Row_In[2];
						Row_In[4] <= Row_In[3];
						Row_In[5] <= Row_In[4];
					end
					else begin 
						Row_In[0] <= Row_In[0];
						Row_In[1] <= Row_In[1];
						Row_In[2] <= Row_In[2];
						Row_In[3] <= Row_In[3];
						Row_In[4] <= Row_In[4];
						Row_In[5] <= Row_In[5];
					end
			default: begin 
						Row_In[0] <= Row_In[0];
						Row_In[1] <= Row_In[1];
						Row_In[2] <= Row_In[2];
						Row_In[3] <= Row_In[3];
						Row_In[4] <= Row_In[4];
						Row_In[5] <= Row_In[5];
					end
		endcase
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		out_valid <= 1'd0;
    end
	else if (!in_rst)
		out_valid <= 1'd0;
	else 	
	case(current_state)
		s_output : if (cnt == 4'd12) out_valid <= 1'd0;
			else out_valid <= 1'd1;
		default: out_valid <= 1'd0;
	endcase
end

reg [3:0]outdata[11:0];


always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		for (i = 0; i<12;i=i+1)
			outdata[i] <= 4'd15;
    end
	else if(!in_rst)begin
		for (i = 0; i<12;i=i+1)
			outdata[i] <= 4'd15;
    end
	else begin
		case(current_state)
		s_cul:
		for (i = 0; i<12;i=i+1)
			outdata[i] <= c_ans[i];
		default:
		for (i = 0; i<12;i=i+1)
			outdata[i] <= outdata[i] ;
		endcase
	end
end


always@(posedge clk or negedge rst_n)begin
	if (!rst_n)begin
		out <= 4'd0;
	end
	else if (!in_rst)begin
		out <= 4'd0;
	end
	else begin
		case(current_state)
			s_output : 
				case(cnt) 
					4'd0: out <= outdata[0];
					4'd1: out <= outdata[1];
					4'd2: out <= outdata[2];
					4'd3: out <= outdata[3];
					4'd4: out <= outdata[4];
					4'd5: out <= outdata[5];
					4'd6: out <= outdata[6];
					4'd7: out <= outdata[7];
					4'd8: out <= outdata[8];
					4'd9: out <= outdata[9];
					4'd10: out <= outdata[10];
					4'd11: out <= outdata[11];
					default:out <= 4'd0;
				endcase
			default: out <= 4'd0;
		endcase
	end
end





generate
for (NN=0 ; NN<12;NN=NN+1)begin
assign Select_Mask[0][NN] = able_[NN][0];
assign Select_Mask[1][NN] = col1_map[NN][0];
assign Select_Mask[2][NN] = col2_map[NN][0];
assign Select_Mask[3][NN] = col3_map[NN][0];
assign Select_Mask[4][NN] = col4_map[NN][0];
assign Select_Mask[5][NN] = col5_map[NN][0];
assign Select_Mask[6][NN] = col6_map[NN][0];
assign Select_Mask[7][NN] = col7_map[NN][0];
assign Select_Mask[8][NN] = col8_map[NN][0];
assign Select_Mask[9][NN] = col9_map[NN][0];
assign Select_Mask[10][NN] = col10_map[NN][0];
assign Select_Mask[11][NN] = col11_map[NN][0];
end 
endgenerate
generate
for (NN = 0;NN<12;NN=NN+1)begin

/*
assign col_mask[NN] = Select_Mask[NN]|loc_mask[NN];

assign check[NN][0] = &col_mask[NN][11:8];
assign check[NN][1] = &col_mask[NN][7:4];
assign check[NN][2] = &col_mask[NN][3:0];
if (check[NN][2] == 1'd0)begin
					if (col_mask[NN][0] == 1'd0)
						row_sel[NN]= 4'd0;
					else if (col_mask[NN][1] == 1'd0)
						row_sel[NN]= 4'd1;
					else if (col_mask[NN][2] == 1'd0)
						row_sel[NN]= 4'd2;
					else
						row_sel[NN]= 4'd3;
				end 
				else if(check[NN][1] == 1'd0)begin
					if (col_mask[NN][4] == 1'd0)
						row_sel[NN]= 4'd4;
					else if (col_mask[NN][5] == 1'd0)
						row_sel[NN]= 4'd5;
					else if (col_mask[NN][6] == 1'd0)
						row_sel[NN]= 4'd6;
					else
						row_sel[NN]= 4'd3;
				end
				else if(check[NN][0] == 1'd0)begin
					if (col_mask[NN][8] == 1'd0)
						row_sel[NN]= 4'd8;
					else if (col_mask[NN][9] == 1'd0)
						row_sel[NN]= 4'd9;
					else if (col_mask[NN][10] == 1'd0)
						row_sel[NN]= 4'd10;
					else
						row_sel[NN]= 4'd11;
				end
				else begin
					row_sel[NN]=4'd12;
				end 
*/
always@(*)begin
		case(current_state)
			s_cul:
			if (c[NN] == 1'd1)begin
				row_sel[NN]=4'd15;
			end
			else if (col_sel == Col[NN])begin
				if (T_Select_Mask[NN][0] == 1'b0)begin
					if (T_S_L[NN][0] == 1'd0)begin
						row_sel[NN] = 4'd0;
					end 
					else if (T_S_L[NN][1] == 1'd0)begin
						row_sel[NN] = 4'd1;
					end 
					else if (T_S_L[NN][2] == 1'd0)begin
						row_sel[NN] = 4'd2;
					end 
					else begin
						row_sel[NN] = 4'd3;
					end 
				end 
				else if (T_Select_Mask[NN][1] == 1'b0)begin
					if (T_S_L[NN][4] == 1'd0)begin
						row_sel[NN] = 4'd4;
					end 
					else if (T_S_L[NN][5] == 1'd0)begin
						row_sel[NN] = 4'd5;
					end 
					else if (T_S_L[NN][6] == 1'd0)begin
						row_sel[NN] = 4'd6; 
					end 
					else begin
						row_sel[NN] = 4'd7;
					end 
				end 
				else if (T_Select_Mask[NN][2] == 1'b0)begin
					if (T_S_L[NN][8] == 1'd0)begin
						row_sel[NN] = 4'd8;
					end 
					else if (T_S_L[NN][9] == 1'd0)begin
						row_sel[NN] = 4'd9;
					end 
					else if (T_S_L[NN][10] == 1'd0)begin
						row_sel[NN] = 4'd10;
					end 
					else begin
						row_sel[NN] = 4'd11;
					end 
				end 
				else 
					row_sel[NN] = 4'd12;
			end
			else begin
				row_sel[NN] =r_row_sel[NN];
			end
			default: row_sel[NN] = r_row_sel[NN];
		endcase
end

end
endgenerate

/*
				if (Select_Mask[NN][0]==1'd0 &&loc_mask[NN][0]==1'd0)
					row_sel[NN] = 4'd0;
				else if (Select_Mask[NN][1]==1'd0 &&loc_mask[NN][1]==1'd0)
					row_sel[NN] = 4'd1;
				else if (Select_Mask[NN][2]==1'd0 &&loc_mask[NN][2]==1'd0)
					row_sel[NN] = 4'd2;
				else if (Select_Mask[NN][3]==1'd0 &&loc_mask[NN][3]==1'd0)
					row_sel[NN] = 4'd3;
				else if (Select_Mask[NN][4]==1'd0 &&loc_mask[NN][4]==1'd0)
					row_sel[NN] = 4'd4;
				else if (Select_Mask[NN][5]==1'd0 &&loc_mask[NN][5]==1'd0)
					row_sel[NN] = 4'd5;
				else if (Select_Mask[NN][6]==1'd0 &&loc_mask[NN][6]==1'd0)
					row_sel[NN] = 4'd6;
				else if (Select_Mask[NN][7]==1'd0 &&loc_mask[NN][7]==1'd0)
					row_sel[NN] = 4'd7;
				else if (Select_Mask[NN][8]==1'd0 &&loc_mask[NN][8]==1'd0)
					row_sel[NN] = 4'd8;
				else if (Select_Mask[NN][9]==1'd0 &&loc_mask[NN][9]==1'd0)
					row_sel[NN] = 4'd9;
				else if (Select_Mask[NN][10]==1'd0 &&loc_mask[NN][10]==1'd0)
					row_sel[NN] = 4'd10;
				else if (Select_Mask[NN][11]==1'd0 &&loc_mask[NN][11]==1'd0)
					row_sel[NN] = 4'd11;
				else 
					row_sel[NN] = 4'd12;
				
				*/
generate
for (NN=0;NN<12;NN=NN+1)begin

always@(posedge clk or negedge rst_n)begin
	if (!rst_n)begin
		r_row_sel[NN] <= 4'd15;
	end
	else if (!in_rst)begin
		r_row_sel[NN] <= 4'd15;
	end
	else begin
		case(current_state)
			s_cul:
			if (c[NN] == 1'd1)begin
				r_row_sel[NN]<=4'd15;
			end
			else if (col_sel == Col[NN])begin
				r_row_sel[NN] <= row_sel[NN];
			end
			else begin
				r_row_sel[NN] <= r_row_sel[NN];
			end
			default: r_row_sel[NN] <= r_row_sel[NN];
		endcase
	end
end

end
endgenerate




generate
for (MM=0; MM<12;MM=MM+1)begin
	for (NN=0; NN<12;NN=NN+1)begin
	assign T_S_L[NN][MM] = Select_Mask[NN][MM]|loc_mask[NN][MM];
	end
end
endgenerate
generate
for (NN=0; NN<12;NN=NN+1)begin
	assign T_Select_Mask[NN][0]= T_S_L[NN][0]&T_S_L[NN][1]&T_S_L[NN][2]&T_S_L[NN][3];
	assign T_Select_Mask[NN][1]= T_S_L[NN][4]&T_S_L[NN][5]&T_S_L[NN][6]&T_S_L[NN][7];
	assign T_Select_Mask[NN][2]= T_S_L[NN][8]&T_S_L[NN][9]&T_S_L[NN][10]&T_S_L[NN][11];
end
endgenerate
generate
for (NN=0; NN<12;NN=NN+1)begin
always@(posedge clk or negedge rst_n)begin
	if (!rst_n)begin
		slash1_sel[NN] <= 5'd31;
	end
	else if (!in_rst)begin
		slash1_sel[NN] <= 5'd31;
	end
	else begin
		case(current_state)
			s_cul:
			if (c[NN] == 1'd1)begin
				slash1_sel[NN]<=5'd31;
			end
			else if (col_sel == Col[NN])begin
				if (T_Select_Mask[NN][0] == 1'b0)begin
					if (T_S_L[NN][0] == 1'd0)begin
						slash1_sel[NN]<= slash1[0][NN]; 
					end 
					else if (T_S_L[NN][1] == 1'd0)begin
						slash1_sel[NN]<= slash1[1][NN]; 
					end 
					else if (T_S_L[NN][2] == 1'd0)begin
						slash1_sel[NN]<= slash1[2][NN]; 
					end 
					else begin
						slash1_sel[NN]<= slash1[3][NN]; 
					end 
				end 
				else if (T_Select_Mask[NN][1] == 1'b0)begin
					if (T_S_L[NN][4] == 1'd0)begin
						slash1_sel[NN]<= slash1[4][NN]; 
					end 
					else if (T_S_L[NN][5] == 1'd0)begin
						slash1_sel[NN]<= slash1[5][NN]; 
					end 
					else if (T_S_L[NN][6] == 1'd0)begin
						slash1_sel[NN]<= slash1[6][NN]; 
					end 
					else begin
						slash1_sel[NN]<= slash1[7][NN]; 
					end 
				end 
				else if (T_Select_Mask[NN][2] == 1'b0)begin
					if (T_S_L[NN][8] == 1'd0)begin
						slash1_sel[NN]<= slash1[8][NN]; 
					end 
					else if (T_S_L[NN][9] == 1'd0)begin
						slash1_sel[NN]<= slash1[9][NN]; 
					end 
					else if (T_S_L[NN][10] == 1'd0)begin
						slash1_sel[NN]<= slash1[10][NN]; 
					end 
					else begin
						slash1_sel[NN]<= slash1[11][NN]; 
					end 
				end 
				else 
					slash1_sel[NN]<= 5'd31; 
			end
			else begin
				slash1_sel[NN] <= slash1_sel[NN];
			end
			default: slash1_sel[NN] <= slash1_sel[NN];
		endcase
	end
end

end
endgenerate

/*

if (Select_Mask[NN][0]==1'd0 &&loc_mask[NN][0]==1'd0)
					slash1_sel[NN]<= slash1[0][NN];
				else if (Select_Mask[NN][1]==1'd0 &&loc_mask[NN][1]==1'd0)
					slash1_sel[NN]<= slash1[1][NN];
				else if (Select_Mask[NN][2]==1'd0 &&loc_mask[NN][2]==1'd0)
					slash1_sel[NN]<= slash1[2][NN];
				else if (Select_Mask[NN][3]==1'd0 &&loc_mask[NN][3]==1'd0)
					slash1_sel[NN]<= slash1[3][NN];
				else if (Select_Mask[NN][4]==1'd0 &&loc_mask[NN][4]==1'd0)
					slash1_sel[NN]<= slash1[4][NN];
				else if (Select_Mask[NN][5]==1'd0 &&loc_mask[NN][5]==1'd0)
					slash1_sel[NN]<= slash1[5][NN];
				else if (Select_Mask[NN][6]==1'd0 &&loc_mask[NN][6]==1'd0)
					slash1_sel[NN]<= slash1[6][NN];
				else if (Select_Mask[NN][7]==1'd0 &&loc_mask[NN][7]==1'd0)
					slash1_sel[NN]<= slash1[7][NN];
				else if (Select_Mask[NN][8]==1'd0 &&loc_mask[NN][8]==1'd0)
					slash1_sel[NN]<= slash1[8][NN];
				else if (Select_Mask[NN][9]==1'd0 &&loc_mask[NN][9]==1'd0)
					slash1_sel[NN]<= slash1[9][NN];
				else if (Select_Mask[NN][10]==1'd0 &&loc_mask[NN][10]==1'd0)
					slash1_sel[NN]<= slash1[10][NN];
				else if (Select_Mask[NN][11]==1'd0 &&loc_mask[NN][11]==1'd0)
					slash1_sel[NN]<= slash1[11][NN];
				else 
					slash1_sel[NN]<= 5'd31;
			end
*/


generate
for (NN=0; NN<12;NN=NN+1)begin

always@(posedge clk or negedge rst_n)begin
	if (!rst_n )begin
		slash2_sel[NN] <= 5'd31;
	end
	else if (!in_rst)begin
		slash2_sel[NN] <= 5'd31;
	end
	else begin
		case(current_state)
			s_cul:
			if (c[NN] == 1'd1)begin
				slash2_sel[NN]<=5'd31;
			end
			else if (col_sel == Col[NN])begin
				if (T_Select_Mask[NN][0] == 1'b0)begin
					if (T_S_L[NN][0] == 1'd0)begin
						slash2_sel[NN]<= slash2[0][NN]; 
					end 
					else if (T_S_L[NN][1] == 1'd0)begin
						slash2_sel[NN]<= slash2[1][NN]; 
					end 
					else if (T_S_L[NN][2] == 1'd0)begin
						slash2_sel[NN]<= slash2[2][NN]; 
					end 
					else begin
						slash2_sel[NN]<= slash2[3][NN]; 
					end 
				end 
				else if (T_Select_Mask[NN][1] == 1'b0)begin
					if (T_S_L[NN][4] == 1'd0)begin
						slash2_sel[NN]<= slash2[4][NN]; 
					end 
					else if (T_S_L[NN][5] == 1'd0)begin
						slash2_sel[NN]<= slash2[5][NN]; 
					end 
					else if (T_S_L[NN][6] == 1'd0)begin
						slash2_sel[NN]<= slash2[6][NN]; 
					end 
					else begin
						slash2_sel[NN]<= slash2[7][NN]; 
					end 
				end 
				else if (T_Select_Mask[NN][2] == 1'b0)begin
					if (T_S_L[NN][8] == 1'd0)begin
						slash2_sel[NN]<= slash2[8][NN]; 
					end 
					else if (T_S_L[NN][9] == 1'd0)begin
						slash2_sel[NN]<= slash2[9][NN]; 
					end 
					else if (T_S_L[NN][10] == 1'd0)begin
						slash2_sel[NN]<= slash2[10][NN]; 
					end 
					else begin
						slash2_sel[NN]<= slash2[11][NN]; 
					end 
				end 
				else 
					slash2_sel[NN]<= 5'd31; 
			end
			else begin
				slash2_sel[NN] <= slash2_sel[NN];
			end
			default: slash2_sel[NN] <= slash2_sel[NN];
		endcase
	end
end

end
endgenerate


always@(posedge clk or negedge rst_n)begin
	if (!rst_n)begin
		col_sel <= 4'd15;
	end
	else if ( !in_rst)begin
		col_sel <= 4'd15;
	end
	else begin
		case(current_state)
			s_cul: col_sel <= next_col_sel;
			default col_sel <= col_sel ;
		endcase
	end
end



always@(*)begin
	case(col_sel)
	4'd0:begin
		next_col_sel = 4'd1;
	end
	4'd1:begin
		if(c[1]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd0;
			else 
				next_col_sel = 4'd2;
		end
		else if (row_sel[1] == 4'd12)
			next_col_sel = 4'd0;
		else 
			next_col_sel = 4'd2;
	end
	4'd2:begin
		if(c[2]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd1;
			else 
				next_col_sel = 4'd3;
		end
		else if (row_sel[2] == 4'd12)
			next_col_sel = 4'd1;
		else
			next_col_sel = 4'd3;
	end
	4'd3:begin
		if(c[3]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd2;
			else 
				next_col_sel = 4'd4;
		end
		else if (row_sel[3] == 4'd12)
			next_col_sel = 4'd2;
		else
			next_col_sel = 4'd4;
	end
	4'd4:begin
		if(c[4]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd3;
			else 
				next_col_sel = 4'd5;
		end
		else if (row_sel[4] == 4'd12)
			next_col_sel = 4'd3;
		else
			next_col_sel = 4'd5;
	end
	4'd5:begin
		if(c[5]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd4;
			else 
				next_col_sel = 4'd6;
		end
		else if (row_sel[5] == 4'd12)
			next_col_sel = 4'd4;
		else
			next_col_sel = 4'd6;
	end
	4'd6:begin
		if(c[6]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd5;
			else 
				next_col_sel = 4'd7;
		end
		else if (row_sel[6] == 4'd12)
			next_col_sel = 4'd5;
		else
			next_col_sel = 4'd7;
	end
	4'd7:begin
		if(c[7]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd6;
			else 
				next_col_sel = 4'd8;
		end
		else if (row_sel[7] == 4'd12)
			next_col_sel = 4'd6;
		else
			next_col_sel = 4'd8;
	end
	4'd8:begin
		if(c[8]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd7;
			else 
				next_col_sel = 4'd9;
		end
		else if (row_sel[8] == 4'd12)
			next_col_sel = 4'd7;
		else
			next_col_sel = 4'd9;
	end
	4'd9:begin
		if(c[9]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd8;
			else 
				next_col_sel = 4'd10;
		end
		else if (row_sel[9] == 4'd12)
			next_col_sel = 4'd8;
		else
			next_col_sel = 4'd10;
	end
	4'd10:begin
		if(c[10]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd9;
			else 
				next_col_sel = 4'd11;
		end
		else if (row_sel[10] == 4'd12)
			next_col_sel = 4'd9;
		else
			next_col_sel = 4'd11;
	end
	4'd11:begin
		if(c[11]==1'd1)begin
			if (forword == 1'd0)
				next_col_sel = 4'd12;
			else 
				next_col_sel = 4'd12;
		end
		else if (row_sel[11] == 4'd12)
			next_col_sel = 4'd10;
		else
			next_col_sel = 4'd12;
	end
	4'd15:begin
		next_col_sel = 4'd0;
	end
	default: next_col_sel = col_sel;
	endcase
end

always@(posedge clk or negedge rst_n)begin
	if (!rst_n )begin
		forword <= 1'd1;
	end
	
	else if (!in_rst)begin
		forword <= 1'd1;
	end
	else begin
		case(current_state)
			s_cul: forword <= next_forword;
			default: forword <= forword ;
		endcase
	end
end

always@(*)begin
	case(col_sel)
	4'd0:begin
		next_forword = 1'd1;
	end
	4'd1:begin
		if (c[1]==1'd1)
			next_forword = forword;
		else if (row_sel[1] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	4'd2:begin
		if (c[2]==1'd1)
			next_forword = forword;
		else if (row_sel[2] == 4'd12)
			next_forword = 1'd0;
		else
			next_forword = 1'd1;
	end
	4'd3:begin
		if (c[3]==1'd1)
			next_forword = forword;
		else if (row_sel[3] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	4'd4:begin
		if (c[4]==1'd1)
			next_forword = forword;
		else if (row_sel[4] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	4'd5:begin
		if (c[5]==1'd1)
			next_forword = forword;
		else if (row_sel[5] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	4'd6:begin
		if (c[6]==1'd1)
			next_forword = forword;
		else if (row_sel[6] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	4'd7:begin
		if (c[7]==1'd1)
			next_forword = forword;
		else if (row_sel[7] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	4'd8:begin
		if (c[8]==1'd1)
			next_forword = forword;
		else if (row_sel[8] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	4'd9:begin
		if (c[9]==1'd1)
			next_forword = forword;
		else if (row_sel[9] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	4'd10:begin
		if (c[10]==1'd1)
			next_forword = forword;
		else if (row_sel[10] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	4'd11:begin
		if (c[11]==1'd1)
			next_forword = forword;
		else if (row_sel[11] == 4'd12)
			next_forword = 1'd0;
		else 
			next_forword = 1'd1;
	end
	default: next_forword = forword;
	endcase
end



assign slash1_In[0] = Row_In[0] + Col_In[0];
assign slash1_In[1] = Row_In[1] + Col_In[1];
assign slash1_In[2] = Row_In[2] + Col_In[2];
assign slash1_In[3] = Row_In[3] + Col_In[3];
assign slash1_In[4] = Row_In[4] + Col_In[4];
assign slash1_In[5] = Row_In[5] + Col_In[5];
assign slash2_In[0] = (Row_In[0]==4'd15)? 5'd31:((5'd11 + {1'd0,Row_In[0]}) - {1'd0,Col_In[0]});
assign slash2_In[1] = (Row_In[1]==4'd15)? 5'd31:((5'd11 + {1'd0,Row_In[1]}) - {1'd0,Col_In[1]});
assign slash2_In[2] = (Row_In[2]==4'd15)? 5'd31:((5'd11 + {1'd0,Row_In[2]}) - {1'd0,Col_In[2]});
assign slash2_In[3] = (Row_In[3]==4'd15)? 5'd31:((5'd11 + {1'd0,Row_In[3]}) - {1'd0,Col_In[3]});
assign slash2_In[4] = (Row_In[4]==4'd15)? 5'd31:((5'd11 + {1'd0,Row_In[4]}) - {1'd0,Col_In[4]});
assign slash2_In[5] = (Row_In[5]==4'd15)? 5'd31:((5'd11 + {1'd0,Row_In[5]}) - {1'd0,Col_In[5]});

//GOOD LUCKY
generate
for(MM=0;MM<12;MM=MM+1)begin
	assign c_in1[MM] = (Col_In[0] == Col[MM])? 1'd1:1'd0;
	assign c_in2[MM] = (Col_In[1] == Col[MM])? 1'd1:1'd0;
	assign c_in3[MM] = (Col_In[2] == Col[MM])? 1'd1:1'd0;
	assign c_in4[MM] = (Col_In[3] == Col[MM])? 1'd1:1'd0;
	assign c_in5[MM] = (Col_In[4] == Col[MM])? 1'd1:1'd0;
	assign c_in6[MM] = (Col_In[5] == Col[MM])? 1'd1:1'd0;
	assign c_In[MM] = ({4{c_in1[MM]}}&Row_In[0])|({4{c_in2[MM]}}&Row_In[1])|({4{c_in3[MM]}}&Row_In[2])|({4{c_in4[MM]}}&Row_In[3])|({4{c_in5[MM]}}&Row_In[4])|({4{c_in6[MM]}}&Row_In[5]);
	assign s1_In[MM] = ({5{c_in1[MM]}}&slash1_In[0])|({5{c_in2[MM]}}&slash1_In[1])|({5{c_in3[MM]}}&slash1_In[2])|({5{c_in4[MM]}}&slash1_In[3])|({5{c_in5[MM]}}&slash1_In[4])|({5{c_in6[MM]}}&slash1_In[5]);
	assign s2_In[MM] = ({5{c_in1[MM]}}&slash2_In[0])|({5{c_in2[MM]}}&slash2_In[1])|({5{c_in3[MM]}}&slash2_In[2])|({5{c_in4[MM]}}&slash2_In[3])|({5{c_in5[MM]}}&slash2_In[4])|({5{c_in6[MM]}}&slash2_In[5]);
	assign c[MM] = c_in1[MM]|c_in2[MM]|c_in3[MM]|c_in4[MM]|c_in5[MM]|c_in6[MM];
	
	assign c_ans[MM] = (c[MM] == 1'd1)? c_In[MM]:r_row_sel[MM];
	assign s1_ans[MM] = (c[MM] == 1'd1)? s1_In[MM]:slash1_sel[MM];
	assign s2_ans[MM] = (c[MM] == 1'd1)? s2_In[MM]:slash2_sel[MM];
end
endgenerate

generate
for(NN=0;NN<12;NN=NN+1)begin:Row_Check
	assign r_in1[NN] = (Row_In[0] == Row[NN])? 1'd1:1'd0;
	assign r_in2[NN] = (Row_In[1] == Row[NN])? 1'd1:1'd0;
	assign r_in3[NN] = (Row_In[2] == Row[NN])? 1'd1:1'd0;
	assign r_in4[NN] = (Row_In[3] == Row[NN])? 1'd1:1'd0;
	assign r_in5[NN] = (Row_In[4] == Row[NN])? 1'd1:1'd0;
	assign r_in6[NN] = (Row_In[5] == Row[NN])? 1'd1:1'd0;
	assign r[NN] = r_in1[NN]|r_in2[NN]|r_in3[NN]|r_in4[NN]|r_in5[NN]|r_in6[NN];
end
endgenerate


generate 
for (NN=0;NN<12;NN=NN+1) begin

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		for (i=0;i<12;i=i+1)begin
			loc_mask[NN] <= 12'd0;
		end
    end
	else if(!in_rst)begin
		for (i=0;i<12;i=i+1)begin
			loc_mask[NN] <= 12'd0;
		end
    end
	else begin
		case(current_state)
		s_cul:
			case(r_row_sel[NN])
			4'd0:
				loc_mask[NN] <= 12'b0000_0000_0001;
			4'd1:
				loc_mask[NN] <= 12'b0000_0000_0011;
			4'd2:
				loc_mask[NN] <= 12'b0000_0000_0111;
			4'd3:
				loc_mask[NN] <= 12'b0000_0000_1111;
			4'd4:
				loc_mask[NN] <= 12'b0000_0001_1111;
			4'd5:
				loc_mask[NN] <= 12'b0000_0011_1111;
			4'd6:
				loc_mask[NN] <= 12'b0000_0111_1111;
			4'd7:
				loc_mask[NN] <= 12'b0000_1111_1111;
			4'd8:
				loc_mask[NN] <= 12'b0001_1111_1111;
			4'd9:
				loc_mask[NN] <= 12'b0011_1111_1111;
			4'd10:
				loc_mask[NN] <= 12'b0111_1111_1111;
			4'd11:
				loc_mask[NN] <= 12'b1111_1111_1111;
			4'd12:
				loc_mask[NN] <= 12'b0000_0000_0000;
			4'd15:
				loc_mask[NN] <= 12'b0000_0000_0000;
			default:loc_mask[NN]<=loc_mask[NN];
			endcase
		default:loc_mask[NN]<=loc_mask[NN];	
		endcase
	end
end

end
endgenerate

//input map
generate
for (NN=0;NN<12;NN=NN+1) begin: col_able
	for (MM=0;MM<12;MM=MM+1)begin: row_able
		assign slash1_check_In_1[NN][MM] = (slash1_In[0] == slash1[NN][MM])?1'd1:1'd0;
		assign slash1_check_In_2[NN][MM] = (slash1_In[1] == slash1[NN][MM])?1'd1:1'd0;
		assign slash1_check_In_3[NN][MM] = (slash1_In[2] == slash1[NN][MM])?1'd1:1'd0;
		assign slash1_check_In_4[NN][MM] = (slash1_In[3] == slash1[NN][MM])?1'd1:1'd0;
		assign slash1_check_In_5[NN][MM] = (slash1_In[4] == slash1[NN][MM])?1'd1:1'd0;
		assign slash1_check_In_6[NN][MM] = (slash1_In[5] == slash1[NN][MM])?1'd1:1'd0;
		assign slash1_check[NN][MM] = slash1_check_In_1[NN][MM]|slash1_check_In_2[NN][MM]|slash1_check_In_3[NN][MM]|slash1_check_In_4[NN][MM]|slash1_check_In_5[NN][MM]|slash1_check_In_6[NN][MM];

		assign slash2_check_In_1[NN][MM] = (slash2_In[0] == slash2[NN][MM])?1'd1:1'd0;
		assign slash2_check_In_2[NN][MM] = (slash2_In[1] == slash2[NN][MM])?1'd1:1'd0;
		assign slash2_check_In_3[NN][MM] = (slash2_In[2] == slash2[NN][MM])?1'd1:1'd0;
		assign slash2_check_In_4[NN][MM] = (slash2_In[3] == slash2[NN][MM])?1'd1:1'd0;
		assign slash2_check_In_5[NN][MM] = (slash2_In[4] == slash2[NN][MM])?1'd1:1'd0;
		assign slash2_check_In_6[NN][MM] = (slash2_In[5] == slash2[NN][MM])?1'd1:1'd0;
		assign slash2_check[NN][MM] = slash2_check_In_1[NN][MM]|slash2_check_In_2[NN][MM]|slash2_check_In_3[NN][MM]|slash2_check_In_4[NN][MM]|slash2_check_In_5[NN][MM]|slash2_check_In_6[NN][MM];

		assign able_[NN][MM] = slash1_check[NN][MM]|slash2_check[NN][MM]|r[NN]|c[MM];
	end
end
endgenerate

generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<12;MM=MM+1)begin
	
		always@(posedge clk or negedge rst_n)begin
			if(!rst_n)begin
				able_reg[NN][MM] <= 1'd0;
			end
			else if(!in_rst)begin
				able_reg[NN][MM] <= 1'd0;
			end
			else begin
				case(current_state)
				s_cul:
						able_reg[NN][MM] <= able_[NN][MM];
				default: able_reg[NN][MM] <= able_reg[NN][MM];
				endcase
			end
		end

	end
end
endgenerate
//1111111111111111111111111111111111111111111111111111111111111111111111111111111111111
//col0 map
//for col1 12row 11col

generate
for (MM=0;MM<12;MM=MM+1)begin :row_1
	assign r_stage0[MM] = (r_row_sel[0] == Row[MM])?1'd1:1'd0;
end

for (NN=0;NN<12;NN=NN+1) begin:col_1
	for (MM=0;MM<11;MM=MM+1)begin:col_1_0
		assign slash1_check_stage0[NN][MM] = (slash1_sel[0] == slash1[NN][MM+1])?1'd1:1'd0;
		assign slash2_check_stage0[NN][MM] = (slash2_sel[0] == slash2[NN][MM+1])?1'd1:1'd0;
		assign col1_map[NN][MM] = slash1_check_stage0[NN][MM]|slash2_check_stage0[NN][MM]|r_stage0[NN]|able_reg[NN][MM+1];
	end
end
/*
endgenerate
//for col2 cul


generate
*/
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<11;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg1[NN][MM] <= 1'd0;
    end
	else if( !in_rst)begin
		able_reg1[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg1[NN][MM] <= col1_map[NN][MM];
		default: able_reg1[NN][MM] <= able_reg1[NN][MM];
		endcase
	end
end

	end
end

endgenerate
//111111111111111111111111111111111111111111111111111111111111111111111111111111111111
//22222222222222222222222222222222222222222222222222222222222222222222222222222222222
//for col2: col1造成 12row 10col
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage1[MM] = (r_row_sel[1] == Row[MM])?1'd1:1'd0;
end
endgenerate

generate

for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<10;MM=MM+1)begin
		assign slash1_check_stage1[NN][MM] = (slash1_sel[1] == slash1[NN][MM+2])?1'd1:1'd0;
		assign slash2_check_stage1[NN][MM] = (slash2_sel[1] == slash2[NN][MM+2])?1'd1:1'd0;
		assign col2_map[NN][MM] = slash1_check_stage1[NN][MM]|slash2_check_stage1[NN][MM]|r_stage1[NN]|able_reg1[NN][MM+1];
	end
end
endgenerate

//for col3 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<10;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg2[NN][MM] <= 1'd0;
    end
	else if( !in_rst)begin
		able_reg2[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg2[NN][MM] <= col2_map[NN][MM];
		default: able_reg2[NN][MM] <= able_reg2[NN][MM];
		endcase
	end
end

	end
end
endgenerate
//2222222222222222222222222222222222222222222222222222222222222222222222222222222222222
//33333333333333333333333333333333333333333333333333333333333333333333333333333333
//for col3: col2造成
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage2[MM] = (r_row_sel[2] == Row[MM])?1'd1:1'd0;
end
endgenerate
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<9;MM=MM+1)begin: row_able
		assign slash1_check_stage2[NN][MM] = (slash1_sel[2] == slash1[NN][MM+3])?1'd1:1'd0;
		assign slash2_check_stage2[NN][MM] = (slash2_sel[2] == slash2[NN][MM+3])?1'd1:1'd0;
		assign col3_map[NN][MM] = slash1_check_stage2[NN][MM]|slash2_check_stage2[NN][MM]|r_stage2[NN]|able_reg2[NN][MM+1];
	end
end
endgenerate

//for col4 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<9;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg3[NN][MM] <= 1'd0;
    end
	else if( !in_rst)begin
		able_reg3[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg3[NN][MM] <= col3_map[NN][MM];
		default: able_reg3[NN][MM] <= able_reg3[NN][MM];
		endcase
	end
end

	end
end
endgenerate
//33333333333333333333333333333333333333333333333333333333333333333333333333
//44444444444444444444444444444444444444444444444444444444444444444444444444
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage3[MM] = (r_row_sel[3] == Row[MM])?1'd1:1'd0;
end
endgenerate
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<8;MM=MM+1)begin: row_able
		assign slash1_check_stage3[NN][MM] = (slash1_sel[3] == slash1[NN][MM+4])?1'd1:1'd0;
		assign slash2_check_stage3[NN][MM] = (slash2_sel[3] == slash2[NN][MM+4])?1'd1:1'd0;
		assign col4_map[NN][MM] = slash1_check_stage3[NN][MM]|slash2_check_stage3[NN][MM]|r_stage3[NN]|able_reg3[NN][MM+1];
	end
end
endgenerate

//for col4 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<8;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg4[NN][MM] <= 1'd0;
    end
	else if(!in_rst)begin
		able_reg4[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg4[NN][MM] <= col4_map[NN][MM];
		default: able_reg4[NN][MM] <= able_reg4[NN][MM];
		endcase
	end
end

	end
end
endgenerate
//4444444444444444444444444444444444444444444444444444444444444444444444444
//5555555555555555555555555555555555555555555555555555555555555555555555555
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage4[MM] = (r_row_sel[4] == Row[MM])?1'd1:1'd0;
end
endgenerate
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<7;MM=MM+1)begin: row_able
		assign slash1_check_stage4[NN][MM] = (slash1_sel[4] == slash1[NN][MM+5])?1'd1:1'd0;
		assign slash2_check_stage4[NN][MM] = (slash2_sel[4] == slash2[NN][MM+5])?1'd1:1'd0;
		assign col5_map[NN][MM] = slash1_check_stage4[NN][MM]|slash2_check_stage4[NN][MM]|r_stage4[NN]|able_reg4[NN][MM+1];
	end
end
endgenerate

//for col4 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<7;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n )begin
		able_reg5[NN][MM] <= 1'd0;
    end
	else if(!in_rst)begin
		able_reg5[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg5[NN][MM] <= col5_map[NN][MM];
		default: able_reg5[NN][MM] <= able_reg5[NN][MM];
		endcase
	end
end

	end
end
endgenerate
//55555555555555555555555555555555555555555555555555555555555555555555555
//6666666666666666666666666666666666666666666666666666666666666666666666
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage5[MM] = (r_row_sel[5] == Row[MM])?1'd1:1'd0;
end
endgenerate
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<6;MM=MM+1)begin: row_able
		assign slash1_check_stage5[NN][MM] = (slash1_sel[5] == slash1[NN][MM+6])?1'd1:1'd0;
		assign slash2_check_stage5[NN][MM] = (slash2_sel[5] == slash2[NN][MM+6])?1'd1:1'd0;
		assign col6_map[NN][MM] = slash1_check_stage5[NN][MM]|slash2_check_stage5[NN][MM]|r_stage5[NN]|able_reg5[NN][MM+1];
	end
end
endgenerate

//for col4 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<6;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg6[NN][MM] <= 1'd0;
    end
	else if(!in_rst)begin
		able_reg6[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg6[NN][MM] <= col6_map[NN][MM];
		default: able_reg6[NN][MM] <= able_reg6[NN][MM];
		endcase
	end
end

	end
end
endgenerate
//6666666666666666666666666666666666666666666666666666666666666666666666
//777777777777777777777777777777777777777777777777777777777777777777777
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage6[MM] = (r_row_sel[6] == Row[MM])?1'd1:1'd0;
end
endgenerate
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<5;MM=MM+1)begin: row_able
		assign slash1_check_stage6[NN][MM] = (slash1_sel[6] == slash1[NN][MM+7])?1'd1:1'd0;
		assign slash2_check_stage6[NN][MM] = (slash2_sel[6] == slash2[NN][MM+7])?1'd1:1'd0;
		assign col7_map[NN][MM] = slash1_check_stage6[NN][MM]|slash2_check_stage6[NN][MM]|r_stage6[NN]|able_reg6[NN][MM+1];
	end
end
endgenerate

//for col4 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<5;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg7[NN][MM] <= 1'd0;
    end
	else if(!in_rst)begin
		able_reg7[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg7[NN][MM] <= col7_map[NN][MM];
		default: able_reg7[NN][MM] <= able_reg7[NN][MM];
		endcase
	end
end

	end
end
endgenerate
//7777777777777777777777777777777777777777777777777777777777777777777
//888888888888888888888888888888888888888888888888888888888888888888
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage7[MM] = (r_row_sel[7] == Row[MM])?1'd1:1'd0;
end
endgenerate
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<4;MM=MM+1)begin: row_able
		assign slash1_check_stage7[NN][MM] = (slash1_sel[7] == slash1[NN][MM+8])?1'd1:1'd0;
		assign slash2_check_stage7[NN][MM] = (slash2_sel[7] == slash2[NN][MM+8])?1'd1:1'd0;
		assign col8_map[NN][MM] = slash1_check_stage7[NN][MM]|slash2_check_stage7[NN][MM]|r_stage7[NN]|able_reg7[NN][MM+1];
	end
end
endgenerate

//for col4 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<4;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg8[NN][MM] <= 1'd0;
    end
	else if(!in_rst)begin
		able_reg8[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg8[NN][MM] <= col8_map[NN][MM];
		default: able_reg8[NN][MM] <= able_reg8[NN][MM];
		endcase
	end
end

	end
end
endgenerate
//8888888888888888888888888888888888888888888888888888888888888888888888888888
//99999999999999999999999999999999999999999999999999999999999999999999999999
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage8[MM] = (r_row_sel[8] == Row[MM])?1'd1:1'd0;
end
endgenerate
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<3;MM=MM+1)begin: row_able
		assign slash1_check_stage8[NN][MM] = (slash1_sel[8] == slash1[NN][MM+9])?1'd1:1'd0;
		assign slash2_check_stage8[NN][MM] = (slash2_sel[8] == slash2[NN][MM+9])?1'd1:1'd0;
		assign col9_map[NN][MM] = slash1_check_stage8[NN][MM]|slash2_check_stage8[NN][MM]|r_stage8[NN]|able_reg8[NN][MM+1];
	end
end
endgenerate

//for col4 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<3;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg9[NN][MM] <= 1'd0;
    end
	else if(!in_rst)begin
		able_reg9[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg9[NN][MM] <= col9_map[NN][MM];
		default: able_reg9[NN][MM] <= able_reg9[NN][MM];
		endcase
	end
end

	end
end
endgenerate
//9999999999999999999999999999999999999999999999999999999999999999999999999999999
//1010101010101010101010101010101010
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage9[MM] = (r_row_sel[9] == Row[MM])?1'd1:1'd0;
end
endgenerate
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<2;MM=MM+1)begin: row_able
		assign slash1_check_stage9[NN][MM] = (slash1_sel[9] == slash1[NN][MM+10])?1'd1:1'd0;
		assign slash2_check_stage9[NN][MM] = (slash2_sel[9] == slash2[NN][MM+10])?1'd1:1'd0;
		assign col10_map[NN][MM] = slash1_check_stage9[NN][MM]|slash2_check_stage9[NN][MM]|r_stage9[NN]|able_reg9[NN][MM+1];
	end
end
endgenerate

//for col4 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<2;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg10[NN][MM] <= 1'd0;
    end
	else if(!in_rst)begin
		able_reg10[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg10[NN][MM] <= col10_map[NN][MM];
		default: able_reg10[NN][MM] <= able_reg10[NN][MM];
		endcase
	end
end

	end
end
endgenerate
//10101010101010101010101010
//11 11 11 11 11 11 11 11 
generate
for (MM=0;MM<12;MM=MM+1)begin
	assign r_stage10[MM] = (r_row_sel[10] == Row[MM])?1'd1:1'd0;
end
endgenerate
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<1;MM=MM+1)begin: row_able
		assign slash1_check_stage10[NN][MM] = (slash1_sel[10] == slash1[NN][MM+11])?1'd1:1'd0;
		assign slash2_check_stage10[NN][MM] = (slash2_sel[10] == slash2[NN][MM+11])?1'd1:1'd0;
		assign col11_map[NN][MM] = slash1_check_stage10[NN][MM]|slash2_check_stage10[NN][MM]|r_stage10[NN]|able_reg10[NN][MM+1];
	end
end
endgenerate

//for col4 算
generate
for (NN=0;NN<12;NN=NN+1) begin
	for (MM=0;MM<1;MM=MM+1)begin
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		able_reg11[NN][MM] <= 1'd0;
    end
	else if(!in_rst)begin
		able_reg11[NN][MM] <= 1'd0;
    end
	else begin
		case(current_state)
		s_cul:
			able_reg11[NN][MM] <= col11_map[NN][MM];
		default: able_reg11[NN][MM] <= able_reg11[NN][MM];
		endcase
	end
end

	end
end
endgenerate

//11 11 11 11 11 11 

endmodule 
