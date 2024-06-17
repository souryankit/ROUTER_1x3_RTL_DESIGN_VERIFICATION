class router_dst_agent extends uvm_agent;

      `uvm_component_utils(router_dst_agent)

        router_dst_agent_config m_cfg;

	router_dst_monitor monh;
	router_dst_sequencer seqrh;
	router_dst_driver drvh;

//-----------------  constructor new method  -------------------//

       function new(string name = "router_dst_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//
     virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
                // get the config object using uvm_config_db 
	  if(!uvm_config_db #(router_dst_agent_config)::get(this,"","router_dst_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
	        monh=router_dst_monitor::type_id::create("monh",this);	
		if(m_cfg.is_active==UVM_ACTIVE)
			begin
			drvh=router_dst_driver::type_id::create("drvh",this);
			seqrh=router_dst_sequencer::type_id::create("seqrh",this);
			end
     endfunction

      
//-----------------  connect() phase method  -------------------//
      
	virtual function void connect_phase(uvm_phase phase);
		if(m_cfg.is_active==UVM_ACTIVE)
			drvh.seq_item_port.connect(seqrh.seq_item_export);

	endfunction
   
endclass : router_dst_agent

