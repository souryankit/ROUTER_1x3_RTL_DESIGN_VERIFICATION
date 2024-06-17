
class router_dst_agent_config extends uvm_object;

   `uvm_object_utils(router_dst_agent_config)

   virtual router_dst_if vif;
   uvm_active_passive_enum is_active = UVM_ACTIVE;

   static int dst_mon_xtn_cnt = 0;
   static int dst_drv_data_sent_cnt = 0;


// Standard UVM Methods:
	function new(string name = "router_dst_agent_config");
		super.new(name);
	endfunction


endclass: router_dst_agent_config

