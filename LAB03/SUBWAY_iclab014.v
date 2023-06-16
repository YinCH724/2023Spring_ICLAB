module SUBWAY(
    //Input Port
    clk,
    rst_n,
    in_valid,
    init,
    in0,
    in1,
    in2,
    in3,
    //Output Port
    out_valid,
    out
);


input clk, rst_n;
input in_valid;
input [1:0] init;
input [1:0] in0, in1, in2, in3; 
output reg       out_valid;
output reg [1:0] out;


//==============================================//
//       parameter & integer declaration        //
//==============================================//
parameter s_idle = 2'd0;
parameter s_input = 2'd1;
parameter s_cul = 2'd2;
parameter s_output = 2'd3;

genvar NN;
genvar MM;
integer i;
integer j;
parameter IDX = 9;
//==============================================//
//           reg & wire declaration             //
//==============================================//

reg [1:0]current_state;
reg [1:0]next_state;

reg [1:0]init_pos;
reg [5:0]cnt;
reg [1:0]is_road;
reg [1:0] reg_dif;

reg [1:0]move;

wire UorD;
reg reg_UorD;

wire [1:0]dif1;
wire [1:0]dif2;
wire [1:0]dif;
reg [1:0] next_dif;

reg [1:0]next_pos;
reg [1:0]cur_pos;

reg [1:0] next_step[2:0];

wire [1:0]in_wire[3:0];

reg [1:0]in_a[IDX:0];
reg [1:0]in_b[IDX:0];
reg [1:0]in_c[IDX:0];
reg [1:0]in_d[IDX:0];

reg [1:0]out_pipe[54:0];

reg [1:0]road;



//==============================================//
//                  design                      //
//==============================================//
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
				
		s_input:if (cnt == 6'd7) next_state = s_cul;
				else next_state = s_input;
		s_cul:	if (cnt == 6'd62) next_state = s_output;
				else next_state = s_cul;				
		s_output: if (cnt == 6'd63) next_state = s_idle;
				else next_state = s_output;
		default: next_state = current_state;
		
	endcase 
end
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
		init_pos <= 2'd0;
    end   
    else
		case(current_state)
			s_idle: if(in_valid)begin
				init_pos <= init;
			end
			default: init_pos <= init_pos;
		endcase
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
        cnt <= 6'b0;
    else
		case(current_state)
			s_idle: cnt <= 6'd0;
			s_input: cnt <= cnt+6'd1;
			s_cul: if(cnt == 6'd62 ) cnt <= 6'd0;
					else cnt <= cnt+6'd1;
			s_output: if(cnt == 6'd63) cnt <= 6'd0;
					else cnt <= cnt+6'd1;
			default: cnt <= cnt;
		endcase
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
        out_valid <= 1'b0;
    else
		case(current_state)
			s_idle: out_valid <= 1'd0;
			s_input: out_valid <= 1'd0;
			s_output: 
				if(cnt == 6'd63) out_valid <= 1'd0;
				else   out_valid <= 1'd1;
			default: out_valid <= 1'd0;
		endcase
end

assign UorD = (cur_pos < road)?1'd0: 1'd1; //1-up 0-down
assign dif1 = (cur_pos < road)?road: cur_pos; //1-up 0-down
assign dif2 = (cur_pos < road)?cur_pos: road;
assign dif = dif1 - dif2;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
        reg_UorD <= 2'd0;
    end 
	else begin
		reg_UorD <= UorD;
	end
end

always@(*)begin
	case(cur_pos)
	2'd0: begin
		next_step[0] = 2'b11;
		next_step[1] = in_a[1];
		next_step[2] = in_b[1];
	end
	2'd1: begin
		next_step[0] = in_a[1];
		next_step[1] = in_b[1];
		next_step[2] = in_c[1];
	end
	2'd2: begin
		next_step[0] = in_b[1];
		next_step[1] = in_c[1];
		next_step[2] = in_d[1];
	end
	2'd3: begin
		next_step[0] = in_c[1];
		next_step[1] = in_d[1];
		next_step[2] = 2'b11;
	end
	default: begin
		next_step[0] = in_c[1];
		next_step[1] = in_d[1];
		next_step[2] = 2'b11;
	end
	endcase
end


always@(*)begin
	if (dif != 2'd0) begin
		case(reg_UorD)
		1'd0: 
			case(next_step[2])
			2'd0: move = 2'b01;
			2'd1,
			2'd2,
			2'd3: 
				case(next_step[1])
				2'd0,
				2'd2: move = 2'd0;
				2'd1: move = 2'b11;
				default: move = 2'b0;
				endcase
			default: move = 2'b0;
			endcase
		1'd1: 
			case(next_step[0])
			2'd0: move = 2'b10;
			2'd1,
			2'd2,
			2'd3: 
				case(next_step[1])
				2'd0,
				2'd2: move = 2'd0;
				2'd1: move = 2'b11;
				default: move = 2'b0;
				endcase
			default: move = 2'b0;
			endcase
		default: move = 2'b0;
		endcase
	end
	else begin
		case(next_step[1])
		2'd0,
		2'd2: move = 2'd00;
		2'd1: move = 2'b11;
		default: move = 2'd0;  
		endcase
	end
end
//state
always@(*)begin
	case(cur_pos)
	2'd0:begin
		case (move) 
		2'd1:
			next_pos = 2'd1;
		default:
			next_pos = 2'd0;
		endcase
	end 
	2'd1:begin
		case (move) 
		2'd1:
			next_pos = 2'd2;
		2'd2:
			next_pos = 2'd0;
		default:
			next_pos = 2'd1;
		endcase
	end
	2'd2:begin
		case (move) 
		2'd1:
			next_pos = 2'd3;
		2'd2:
			next_pos = 2'd1;
		default:
			next_pos = 2'd2;
		endcase
	end
	2'd3:begin
		case (move) 
		2'd2:
			next_pos = 2'd2;
		default:
			next_pos = 2'd3;
		endcase
	end
	default:next_pos = cur_pos;
	endcase
end

always@(*)begin
	if (in_b[8] == 2'd0)begin
		is_road = 2'd1;
	end
	else if (in_c[8] == 2'd0)begin
		is_road = 2'd2;
	end
	else if (in_a[8] == 2'd0)begin
		is_road = 2'd0;
	end
	else if (in_d[8] == 2'd0)begin
		is_road = 2'd3;
	end
	else begin
		is_road = 2'd1;
	end
end

always@(posedge clk)begin
	if(!rst_n)begin
        road <= 2'd0;
    end 
	else begin
		case(cnt[2:0])
		3'd0: 
			road <= is_road;
		default: road <= road;
		endcase
	end
end


always @(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
        cur_pos <= 2'd0;
    end 
	else begin
		case(current_state)
		s_idle: cur_pos <= 2'd0;
		s_input: cur_pos <= init_pos;
		s_cul,
		s_output: cur_pos <= next_pos;
		default: cur_pos <= cur_pos;
		endcase
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
        out <= 2'd0;
    end 
	else begin
		case(current_state)
		s_idle: out <= 2'd0;
		s_input: out <= 2'd0;
		s_output: 
			if(cnt == 6'd63) out <= 2'd0;
			else out <= out_pipe[0];//move
		default: out <= 2'd0;
		endcase
	end
end


always @(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
		for (i=0; i<55; i=i+1)begin
			out_pipe[i]<=2'd0; 
		end
    end 
	else begin
		case(current_state)
		s_idle: begin
			for (i=0; i<55; i=i+1)begin
				out_pipe[i]<=2'd0; 
			end
		end
		s_output,
		s_cul: begin
			out_pipe[54] <= move;
			for (i=0; i<54; i=i+1)begin
				out_pipe[i]<=out_pipe[i+1]; 
			end
		end
		default: begin
			for (i=0; i<55; i=i+1)begin
				out_pipe[i]<=2'd0; 
			end
		end
		endcase
	end
end


always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        for (i = 0; i<IDX; i=i+1)begin
			in_a[i]<=2'd0;
		end
    end   
    else
		case(current_state)
			s_idle: if(in_valid)begin
						in_a[IDX-1]<=in0;
						for (i = 0; i<IDX-1; i=i+1)begin
							in_a[i]<=in_a[i+1];
						end
					end
					else begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_a[i]<=in_a[i];
						end
					end
			s_input,
			s_cul:if(in_valid)begin
						in_a[IDX-1]<=in0;
						for (i = 0; i<IDX-1; i=i+1)begin
							in_a[i]<=in_a[i+1];
						end
					end
					else begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_a[i]<=in_a[i];
						end
					end
			s_output:begin
			
				if(in_valid)begin
					in_a[IDX-1]<= in0;
				end
				else begin
					in_a[IDX-1]<= 2'd0;
				end
				
				for (i = 0; i<IDX-1; i=i+1)begin
					in_a[i]<=in_a[i+1];
				end
			end
			default: begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_a[i]<=in_a[i];
						end
					end
		endcase
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        for (i = 0; i<IDX; i=i+1)begin
			in_b[i]<=2'd0;
		end
    end   
    else
		case(current_state)
			s_idle: if(in_valid)begin
						in_b[IDX-1]<=in1;
						for (i = 0; i<IDX-1; i=i+1)begin
							in_b[i]<=in_b[i+1];
						end
					end
					else begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_b[i]<=in_b[i];
						end
					end
			s_input,
			s_cul:if(in_valid)begin
						in_b[IDX-1]<=in1;
						for (i = 0; i<IDX-1; i=i+1)begin
							in_b[i]<=in_b[i+1];
						end
					end
					else begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_b[i]<=in_b[i];
						end
					end
			s_output:begin
			
				if(in_valid)begin
					in_b[IDX-1]<= in1;
				end
				else begin
					in_b[IDX-1]<= 2'd0;
				end
				
				for (i = 0; i<IDX-1; i=i+1)begin
					in_b[i]<=in_b[i+1];
				end
			end
			default: begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_b[i]<=in_b[i];
						end
					end
		endcase
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        for (i = 0; i<IDX; i=i+1)begin
			in_c[i]<=2'd0;
		end
    end   
    else
		case(current_state)
			s_idle: if(in_valid)begin
						in_c[IDX-1]<=in2;
						for (i = 0; i<IDX-1; i=i+1)begin
							in_c[i]<=in_c[i+1];
						end
					end
					else begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_c[i]<=in_c[i];
						end
					end
			s_input,
			s_cul:if(in_valid)begin
						in_c[IDX-1]<=in2;
						for (i = 0; i<IDX-1; i=i+1)begin
							in_c[i]<=in_c[i+1];
						end
					end
					else begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_c[i]<=in_c[i];
						end
					end
			s_output:begin
			
				if(in_valid)begin
					in_c[IDX-1]<= in2;
				end
				else begin
					in_c[IDX-1]<= 2'd0;
				end
				
				for (i = 0; i<IDX-1; i=i+1)begin
					in_c[i]<=in_c[i+1];
				end
			end
			default: begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_c[i]<=in_c[i];
						end
					end
		endcase
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        for (i = 0; i<IDX; i=i+1)begin
			in_d[i]<=2'd0;
		end
    end   
    else
		case(current_state)
			s_idle: if(in_valid)begin
						in_d[IDX-1]<=in3;
						for (i = 0; i<IDX-1; i=i+1)begin
							in_d[i]<=in_d[i+1];
						end
					end
					else begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_d[i]<=in_d[i];
						end
					end
			s_input,
			s_cul:if(in_valid)begin
						in_d[IDX-1]<=in3;
						for (i = 0; i<IDX-1; i=i+1)begin
							in_d[i]<=in_d[i+1];
						end
					end
					else begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_d[i]<=in_d[i];
						end
					end
			s_output:begin
			
				if(in_valid)begin
					in_d[IDX-1]<= in3;
				end
				else begin
					in_d[IDX-1]<= 2'd0;
				end
				
				for (i = 0; i<IDX-1; i=i+1)begin
					in_d[i]<=in_d[i+1];
				end
			end
			default: begin 
						for (i = 0; i<IDX; i=i+1)begin
							in_d[i]<=in_d[i];
						end
					end
		endcase
end


endmodule

