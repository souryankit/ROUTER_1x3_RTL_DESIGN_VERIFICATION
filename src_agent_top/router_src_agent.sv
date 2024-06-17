class router_src_agent extends uvm_agent;

	`uvm_component_utils(router_src_agent)

        router_src_agent_config m_cfg;
       
   // Declare handles of router_src_monitor, router_src_sequencer and router_src_driver
	router_src_monitor smonh;
	router_src_sequencer seqrh;
	router_src_driver sdrvh;

//-----------------  constructor new method  -------------------//

       function new(string name = "router_src_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//
 	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
     
	  	if(!uvm_config_db #(router_src_agent_config)::get(this,"","router_src_agent_config",m_cfg))
			`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
	        
		smonh=router_src_monitor::type_id::create("smonh",this);	
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
			sdrvh=router_src_driver::type_id::create("sdrvh",this);
			seqrh=router_src_sequencer::type_id::create("seqrh",this);
		end
	endfunction

      
//-----------------  connect() phase method  -------------------/
	function void connect_phase(uvm_phase phase);
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
		sdrvh.seq_item_port.connect(seqrh.seq_item_export);
  		end
	endfunction
 
endclass : router_src_agent

