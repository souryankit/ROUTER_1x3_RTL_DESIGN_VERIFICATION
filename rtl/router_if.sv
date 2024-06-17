//-----------ROUTER INTERFACE


interface router_src_if (input clk);

logic resetn,pkt_valid, error, busy;
logic [7:0] data_in;

//clocking block src_drv_cb
clocking src_drv_cb@(posedge clk);
	default input #1 output #1;
	output resetn;
	output pkt_valid;
	output data_in;
	input error;
	input busy;
endclocking

//clocking block src_drv_cb
clocking src_mon_cb@(posedge clk);
	default input #1 output #1;
	input resetn;
	input pkt_valid;
	input data_in;
	input error;
	input busy;
endclocking

//DRIVER MODPORT
modport SRC_DRV_MP(clocking src_drv_cb);

//MONITOR MODPORT
modport SRC_MON_MP(clocking src_mon_cb);

endinterface: router_src_if



interface router_dst_if(input clk);

logic read_enb, valid_out;
logic [7:0] data_out;

//clocking block dst_drv_cb
clocking dst_drv_cb@(posedge clk);
	default input #1 output #1;
	output read_enb;
	input valid_out;
endclocking

//clocking block dst_mon_cb
clocking dst_mon_cb@(posedge clk);
	default input #1 output #1;
	input read_enb;
	input data_out;
endclocking

//DRIVER MODPORTS 
modport DST_DRV_MP(clocking dst_drv_cb);

//MONITOR MODPORTS
modport DST_MON_MP(clocking dst_mon_cb);

endinterface: router_dst_if


/*
//clocking block dst_drv_1
clocking dst_drv_cb1@(posedge clk);
	default input #1 output #1;
	output read_en_1;
	input valid_out_1;
endclocking

//clocking block dst_drv_2
clocking dst_drv_cb2@(posedge clk);
	default input #1 output #1;
	output read_en_2;
	input valid_out_2;
endclocking
*/

/*
//clocking block dst_mon_1
clocking dst_mon_cb1@(posedge clk);
	default input #1 output #1;
	input read_en_1;
	input data_out_1;
endclocking

//clocking block dst_mon_2
clocking dst_mon_cb2@(posedge clk);
	default input #1 output #1;
	input read_en_2;
	input data_out_2;
endclocking

modport DST_DRV1_MP(clocking dst_drv_cb1);

modport DST_DRV2_MP(clocking dst_drv_cb2);


modport DST_MON1_MP(clocking dst_mon_cb1);

modport DST_MON2_MP(clocking dst_mon_cb2);
*/


