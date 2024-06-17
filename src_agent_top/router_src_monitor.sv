
class router_src_monitor extends uvm_monitor;

	`uvm_component_utils(router_src_monitor)

    	virtual router_src_if.SRC_MON_MP vif;
        router_src_agent_config m_cfg;
	src_xtn xtn;
  // Analysis TLM port to connect the monitor to the scoreboard   
	uvm_analysis_port #(src_xtn) monitor_port;

// Standard UVM Methods:


//-----------------  constructor new method  -------------------//
	function new(string name = "router_src_monitor", uvm_component parent);
		super.new(name,parent);
 		monitor_port = new("monitor_port", this);
  	endfunction

//-----------------  build() phase method  -------------------//
 	function void build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(router_src_agent_config)::get(this,"","router_src_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

//-----------------  connect() phase method  -------------------//
 	function void connect_phase(uvm_phase phase);
         super.connect_phase(phase);//uvm
          vif = m_cfg.vif;
        endfunction


//-----------------  run() phase method  -------------------//
	
       task run_phase(uvm_phase phase);
            forever
       		collect_data();  
       endtask

	task collect_data();

	 xtn= src_xtn::type_id::create("xtn");
	//@(vif.src_mon_cb);

	while(vif.src_mon_cb.busy)       
		@(vif.src_mon_cb);

	while(vif.src_mon_cb.pkt_valid!==1) 
		@(vif.src_mon_cb);

	xtn.header=vif.src_mon_cb.data_in;
	xtn.pl=new[xtn.header[7:2]];
	
	@(vif.src_mon_cb)

	foreach(xtn.pl[i])
	 begin                                                                                                                                                                         		while(vif.src_mon_cb.busy)  //added checking of busy
			@(vif.src_mon_cb);

		xtn.pl[i]=vif.src_mon_cb.data_in;
			@(vif.src_mon_cb);
	end
	
	while(vif.src_mon_cb.pkt_valid!==0)          // we are chec
		@(vif.src_mon_cb);

	xtn.parity=vif.src_mon_cb.data_in;

	repeat(2)
		@(vif.src_mon_cb);
	 
	xtn.error = vif.src_mon_cb.error;
			
	@(vif.src_mon_cb);


	`uvm_info(get_type_name(),$sformatf("Printing from Source monitor \n %s", xtn.sprint()),UVM_LOW) 
	monitor_port.write(xtn);
	m_cfg.src_mon_xtn_cnt++;
	
	endtask

//----------------------- report_phase() ----------------------------
  function void report_phase(uvm_phase phase);
    	`uvm_info(get_type_name(), $sformatf("Report: ROUTER Source Monitor Collected %0d Transactions", m_cfg.src_mon_xtn_cnt), UVM_LOW)
  endfunction 

endclass 

