`ifdef RTL
    `define CYCLE_TIME 10.0
`endif
`ifdef GATE
    `define CYCLE_TIME 10.0
`endif


`define PAT_NUM 300

module PATTERN(
    // Output Signals
    clk,
    rst_n,
    in_valid,
    init,
    in0,
    in1,
    in2,
    in3,
    // Input Signals
    out_valid,
    out
);


/* Input for design */
output reg       clk, rst_n;
output reg       in_valid;
output reg [1:0] init;
output reg [1:0] in0, in1, in2, in3; 


/* Output for pattern */
input            out_valid;
input      [1:0] out; 

integer i,j,k,l,f,g,h,u;
integer max_latency;
//random_gen_calculate state

//global
integer latency;
integer total_cycle;
integer total_latency;
integer i_pat;
integer patnum = `PAT_NUM;

reg [1:0]row_map[3:0][63:0];
reg [1:0]init_store;
integer init_pos;

integer answer_count;
/* define clock cycle */
real CYCLE = `CYCLE_TIME;
always #(CYCLE/2.0) clk = ~clk;
integer SEED;

initial begin
	in_valid = 1'd0;
	in0 = 2'dx;
	in1 = 2'dx;
	in2 = 2'dx;
	in3 = 2'dx;
	rst_n = 1'd1;
	max_latency = 0;
	init_rest;
	total_cycle = 0;
	SEED = 17;
	for (i_pat = 0; i_pat < patnum; i_pat = i_pat + 1)begin
		input_gen;
		input_task;
		out_low;
		check_op;
	end
	
	//$display("-----seccess-----");  
    $finish;
	
end




task init_rest; begin
	rst_n = 'b1;
    in_valid = 'b0;
    in0 = 'bx;
    in1 = 'bx;
	in2 = 'bx;
    in3 = 'bx;
    total_latency = 0;
    force clk = 0;
    #CYCLE; rst_n = 0; 
    #CYCLE; rst_n = 1;
    if(out_valid !== 1'b0 || out !=='b0) begin //out!==0
        $display("SPEC 3 IS FAIL!");  
        $finish;
    end
	#CYCLE; release clk;
end
endtask


task out_low;begin
	latency = 0;
	while(out_valid !== 1'b1) begin
		latency = latency + 1;
		if(out !== 0)begin
			$display("SPEC 4 IS FAIL!"); 
			$finish;
		end		
		else if(latency === 3000) begin
			$display("SPEC 6 IS FAIL!"); 
			$finish;
		end
		@(negedge clk);
	end
end
endtask

reg [1:0] no_train;
reg [1:0] must_train;
reg is_train;
reg [1:0]row[3:0];


task input_gen;begin	
	row[0] = 2'd0;
	row[1] = 2'd1;
	row[2] = 2'd2;
	row[3] = 2'd3;
for (j=0; j<8; j=j+1)begin
	no_train = $random(SEED)%'d4;
	must_train = $random(SEED)%'d4;
	while (no_train === must_train)begin
		no_train = $random(SEED)%'d4;
	end
	if (j===0)begin
		init_store = no_train;
	end
	for (i=0; i<4;i=i+1)begin
	is_train = $random(SEED)%'d2;
	if (no_train == row[i])begin
		row_map[i][j*8]= 2'b00;
		row_map[i][j*8+1]= 2'b00;
		row_map[i][j*8+2]= $random(SEED)%'d3;
		row_map[i][j*8+3]= 2'b00;
		row_map[i][j*8+4]= $random(SEED)%'d3;
		row_map[i][j*8+5]= 2'b00;
		row_map[i][j*8+6]= $random(SEED)%'d3;
		row_map[i][j*8+7]= 2'b00;
	end 
	else if (must_train == row[i] ||is_train == 1'd1)begin
		row_map[i][j*8]= 2'b11;
		row_map[i][j*8+1]= 2'b11;
		row_map[i][j*8+2]= 2'b11;
		row_map[i][j*8+3]= 2'b11;
		row_map[i][j*8+4]= $random(SEED)%'d3;
		row_map[i][j*8+5]= 2'b00;
		row_map[i][j*8+6]= $random(SEED)%'d3;
		row_map[i][j*8+7]= 2'b00;
	end
	else begin
		row_map[i][j*8]= 2'b00;
		row_map[i][j*8+1]= 2'b00;
		row_map[i][j*8+2]= $random(SEED)%'d3;
		row_map[i][j*8+3]= 2'b00;
		row_map[i][j*8+4]= $random(SEED)%'d3;
		row_map[i][j*8+5]= 2'b00;
		row_map[i][j*8+6]= $random(SEED)%'d3;
		row_map[i][j*8+7]= 2'b00;
	end
	end
end
end
endtask

integer int_init_store;
integer t;
task input_task;begin
	t = $urandom_range(1, 4);
    for(i = 0; i < t; i = i + 1)begin
    	if (out_valid !== 1'd0)begin
			check_op;
		end 
		else if (out !== 2'd0)begin
			$display("SPEC 4 IS FAIL!"); 
			$finish;
		end
		@(negedge clk);
	end
	in_valid = 1'd1;
	for (i = 0; i<64; i=i+1)begin
		if (i===0)begin
			init = init_store;
			int_init_store = init;
		end
		else begin
			init = 2'dx;
		end
		if (out_valid !== 1'd0)begin
			$display("SPEC 5 IS FAIL!"); 
			$finish;
		end 
		else if (out !== 2'd0)begin
			$display("SPEC 4 IS FAIL!"); 
			$finish;
		end
		in0 = row_map[0][i];
		in1 = row_map[1][i];
		in2 = row_map[2][i];
		in3 = row_map[3][i];
		@(negedge clk);
	end
	in_valid = 1'd0;
	in0 = 2'dx;
	in1 = 2'dx;
	in2 = 2'dx;
	in3 = 2'dx;
end
endtask

integer pos;
integer init_col;
task check_op;begin
	pos = int_init_store;
	init_col = 0;
	for (answer_count = 0; answer_count<63; answer_count = answer_count+1)begin
		if (out_valid === 1'd1)begin
			init_col = init_col + 1;
			case(out)
			2'd0:
				if (row_map[pos][init_col]=== 2'd1)begin
					$display("SPEC 8-2 IS FAIL!"); 
					$finish;
				end
				else if (row_map[pos][init_col]=== 2'b11)begin
					$display("SPEC 8-4 IS FAIL!"); 
					$finish;
				end
			2'd1:begin
				pos = pos+1;
				if (pos > 3)begin
					$display("SPEC 8-1 IS FAIL!"); 
					$finish;
				end
				else if (row_map[pos][init_col]=== 2'd1)begin
					$display("SPEC 8-2 IS FAIL!"); 
					$finish;
				end
				else if(row_map[pos][init_col]=== 2'd2)begin
					$display("SPEC 8-3 IS FAIL!"); 
					$finish;
				end
				else if(row_map[pos][init_col]=== 2'd3)begin
					$display("SPEC 8-4 IS FAIL!"); 
					$finish;
				end
			end
			2'd2:begin
				pos = pos-1;
				if (pos < 0)begin
					$display("SPEC 8-1 IS FAIL!"); 
					$finish;
				end
				else if (row_map[pos][init_col]=== 2'd1)begin
					$display("SPEC 8-2 IS FAIL!"); 
					$finish;
				end
				else if(row_map[pos][init_col]=== 2'd2)begin
					$display("SPEC 8-3 IS FAIL!"); 
					$finish;
				end
				else if(row_map[pos][init_col]=== 2'd3)begin
					$display("SPEC 8-4 IS FAIL!"); 
					$finish;
				end
			end
			2'd3:
				if (row_map[pos][init_col]=== 2'd2)begin
					$display("SPEC 8-3 IS FAIL!"); 
					$finish;
				end
				else if (row_map[pos][init_col-1]=== 2'd1)begin
					$display("SPEC 8-5 IS FAIL!"); 
					$finish;
				end
			endcase
			
		end
		else if (out_valid !== 1'd1)begin 
			if (out !== 2'd0)begin
				$display("SPEC 4 IS FAIL!"); 
				$finish;
			end
			else begin
				$display("SPEC 7 IS FAIL!"); 
				$finish;
			end
		end
		@(negedge clk);
	end
	if(out_valid !== 1'b0 || out !==2'b0) begin //out!==0
		if (out_valid !== 1'b0)begin
			$display("SPEC 7 IS FAIL!");  
	        $finish;
		end
		else if(out !==2'b0)begin
	        $display("SPEC 4 IS FAIL!"); 
			$finish;
		end
	end
end
endtask


endmodule