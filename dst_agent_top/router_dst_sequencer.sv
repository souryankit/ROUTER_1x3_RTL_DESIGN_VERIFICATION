class router_dst_sequencer extends uvm_sequencer #(dst_xtn);

// Factory registration using `uvm_component_utils
	`uvm_component_utils(router_dst_sequencer)

	function new(string name = "router_dst_sequencer",uvm_component parent);
			super.new(name,parent);
	endfunction

endclass

