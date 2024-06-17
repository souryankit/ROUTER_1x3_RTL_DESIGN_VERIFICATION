module top();
	import router_test_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	bit clk;
	
	always	#10 clk = ~clk;
	
	router_src_if in(clk);
	router_dst_if in0(clk);
	router_dst_if in1(clk);
	router_dst_if in2(clk);


	router_top DUT(.clock(clk),
			.resetn(in.resetn), 
			.read_enb_0(in0.read_enb),
			.read_enb_1(in1.read_enb), 
			.read_enb_2(in2.read_enb), 
			.data_in(in.data_in), 
			.pkt_valid(in.pkt_valid),
			.data_out_0(in0.data_out),
			.data_out_1(in1.data_out),
			.data_out_2(in2.data_out), 
			.valid_out_0(in0.valid_out), 				
			.valid_out_1(in1.valid_out), 
			.valid_out_2(in2.valid_out), 
			.error(in.error), 
			.busy(in.busy));

	initial  
	  begin

		//`ifdef VCS
		//$fsdbDumpSVA(0,router_top);
         	//$fsdbDumpvars(0, router_top);
        	//`endif


	uvm_config_db#(virtual router_src_if)::set(null,"","svif_0",in);

	uvm_config_db#(virtual router_dst_if)::set(null,"","dvif_0",in0);
	uvm_config_db#(virtual router_dst_if)::set(null,"","dvif_1",in1);
	uvm_config_db#(virtual router_dst_if)::set(null,"","dvif_2",in2);

	run_test();

	end
endmodule	

/*
//TestBench top module

module tb_top_router();
reg clk, resetn, read_enb_0,read_enb_1, read_enb_2, pkt_valid ;
reg [7:0]data_in;
wire [7:0]data_out_0;
wire [7:0]data_out_1;
wire [7:0]data_out_2;
wire valid_out_0, valid_out_1, valid_out_2, error, busy;

*/
/*
module top_router( clk, resetn, read_enb_0,read_enb_1, read_enb_2, pkt_valid,data_in, 
                  data_out_0,data_out_1, data_out_2, valid_out_0, valid_out_1, valid_out_2, error, busy);
                  
                  
 input clk, resetn, read_enb_0,read_enb_1, read_enb_2, pkt_valid;
 input [7:0]data_in;
 output [7:0]data_out_0;
 output [7:0]data_out_1;
 output [7:0]data_out_2;
 output valid_out_0, valid_out_1, valid_out_2, error, busy;
*/
