
class router_dst_driver extends uvm_driver #(dst_xtn);

	`uvm_component_utils(router_dst_driver)

	 virtual router_dst_if.DST_DRV_MP vif;
   	router_dst_agent_config m_cfg;

//-----------------  constructor new method  -------------------//
	function new(string name ="router_dst_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build() phase method  -------------------//
 	virtual function void build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(router_dst_agent_config)::get(this,"","router_dst_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

//-----------------  connect() phase method  -------------------//
 	virtual function void connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
        endfunction

//-----------------  run() phase method  -------------------// 

	task run_phase(uvm_phase phase);
             forever 
		begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
	     end
	endtask

//-----------------  task send_to_dut() method  -------------------//

   // Add task send_to_dut(dst_xtn handle as an input argument)
	
	task send_to_dut(dst_xtn xtn);

		`uvm_info(get_type_name(),$sformatf("Printing from Destination Driver \n %s", xtn.sprint()),UVM_LOW) 

		while(vif.dst_drv_cb.valid_out !== 1'b1)
			@(vif.dst_drv_cb);

		repeat(xtn.no_of_cycles)
			@(vif.dst_drv_cb);

		vif.dst_drv_cb.read_enb<=1'b1;
		@(vif.dst_drv_cb);

		while(vif.dst_drv_cb.valid_out !==1'b0)
			@(vif.dst_drv_cb);

		vif.dst_drv_cb.read_enb<=1'b0;
		
		repeat(2)
			@(vif.dst_drv_cb);

		m_cfg.dst_drv_data_sent_cnt++;

	endtask

  // UVM report_phase
  virtual function void report_phase(uvm_phase phase);
    	`uvm_info(get_type_name(), $sformatf("Report: ROUTER Destination Driver sent %0d transactions", m_cfg.dst_drv_data_sent_cnt), UVM_LOW)
  endfunction

endclass

