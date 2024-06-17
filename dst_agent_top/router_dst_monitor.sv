
class router_dst_monitor extends uvm_monitor;

 	`uvm_component_utils(router_dst_monitor)

   	 virtual router_dst_if.DST_MON_MP vif;
     	 router_dst_agent_config m_cfg;
	 dst_xtn xtn;
  // Analysis TLM port to connect the monitor to the scoreboard  
	uvm_analysis_port #(dst_xtn) monitor_port;

//-----------------  constructor new method  -------------------//
	function new(string name = "router_dst_monitor", uvm_component parent);
		super.new(name,parent);
 		monitor_port = new("monitor_port", this);

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
       			collect_data();

        endtask


   // Collect Reference Data from DUV IF 
        task collect_data();

	     xtn=dst_xtn::type_id::create("xtn");
	   
		while(vif.dst_mon_cb.read_enb !==1'b1)
      			@(vif.dst_mon_cb);

		@(vif.dst_mon_cb);

		xtn.header = vif.dst_mon_cb.data_out;

		xtn.pl = new [xtn.header[7:2]];

		@(vif.dst_mon_cb);

		foreach(xtn.pl[i])
		begin
	   	      while(vif.dst_mon_cb.read_enb !==1'b1)
      			@(vif.dst_mon_cb);

		   xtn.pl[i] = vif.dst_mon_cb.data_out;
		   @(vif.dst_mon_cb);
		end

		//while(vif.dst_mon_cb.read_enb !==1'b1)
      		//	@(vif.dst_mon_cb);

		xtn.parity = vif.dst_mon_cb.data_out;
		
		repeat(2)
		    @(vif.dst_mon_cb);

		`uvm_info(get_type_name(),$sformatf("Printing from Destination Monitor \n %s", xtn.sprint()),UVM_LOW) 

		monitor_port.write(xtn);

		m_cfg.dst_mon_xtn_cnt++;

	endtask


// UVM report_phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: ROUTER Destination Monitor Collected %0d Transactions",m_cfg.dst_mon_xtn_cnt), UVM_LOW)
  endfunction 

endclass 

