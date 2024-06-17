
class router_src_agent_config extends uvm_object;

	// UVM Factory Registration Macro
	`uvm_object_utils(router_src_agent_config)

	virtual router_src_if vif;
	uvm_active_passive_enum is_active = UVM_ACTIVE;

	static int src_mon_xtn_cnt = 0;
	static int src_drv_data_sent_cnt = 0;

	// Standard UVM Methods:
	function new(string name = "router_src_agent_config");
		super.new(name);
	endfunction


endclass: router_src_agent_config

   	
