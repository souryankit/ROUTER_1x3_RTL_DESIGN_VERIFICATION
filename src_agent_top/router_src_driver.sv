//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class router_src_driver extends uvm_driver #(src_xtn);

	`uvm_component_utils(router_src_driver)

         virtual router_src_if.SRC_DRV_MP vif;
        router_src_agent_config m_cfg;

// Standard UVM Methods:

	
//-----------------  constructor new method  -------------------//
	function new(string name ="router_src_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build() phase method  -------------------//
 	virtual function void build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(router_src_agent_config)::get(this,"","router_src_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

//-----------------  connect() phase method  -------------------//
 	virtual function void connect_phase(uvm_phase phase);
          	vif = m_cfg.vif;
        endfunction

//-----------------  run() phase method  -------------------//

	task run_phase(uvm_phase phase);
		vif.src_drv_cb.resetn<=1'b0;
			@(vif.src_drv_cb);
			@(vif.src_drv_cb);
		vif.src_drv_cb.resetn<=1'b1;
       	
		forever begin
       		   seq_item_port.get_next_item(req);
		   send_to_dut(req);
		   seq_item_port.item_done();
		end
	endtask

//-----------------  task send_to_dut() method  -------------------//
	
	task send_to_dut(src_xtn xtn);
		
		`uvm_info(get_type_name(),$sformatf("Printing from src_driver \n %s", xtn.sprint()),UVM_LOW)
 			//@(vif.src_drv_cb);
			//@(vif.src_drv_cb);
		while(vif.src_drv_cb.busy ==1'b1)  // made a change
			@(vif.src_drv_cb);

		vif.src_drv_cb.pkt_valid<=1'b1;

		vif.src_drv_cb.data_in<=xtn.header;

		@(vif.src_drv_cb);

		foreach(xtn.pl[i])
			begin
				while(vif.src_drv_cb.busy ==1'b1)
					@(vif.src_drv_cb);

			     vif.src_drv_cb.data_in<=xtn.pl[i];
			  	@(vif.src_drv_cb);
			end

		while(vif.src_drv_cb.busy ==1'b1)
			@(vif.src_drv_cb);

		vif.src_drv_cb.pkt_valid<=1'b0;

		vif.src_drv_cb.data_in<=xtn.parity;

		repeat(2)
			@(vif.src_drv_cb);

		 xtn.error = vif.src_drv_cb.error;
          
		m_cfg.src_drv_data_sent_cnt++;
		
		@(vif.src_drv_cb);

	endtask

  // UVM report_phase
  virtual function void report_phase(uvm_phase phase);
      `uvm_info(get_type_name(), $sformatf("Report: Router Source Driver sent %0d transactions", m_cfg.src_drv_data_sent_cnt), UVM_LOW)
  endfunction

endclass

