   
   // Extend virtual_sequencer from uvm_sequencer
class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item) ;
   
   // Factory Registration
	`uvm_component_utils(virtual_sequencer)

	router_src_sequencer src_sqrh[];
	router_dst_sequencer dst_sqrh[];
 
  	router_env_config m_cfg;

   // Define Constructor new() function
	function new(string name="virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

   // function void build_phase(uvm_phase phase)
	virtual function void build_phase(uvm_phase phase);

	     if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
    	     super.build_phase(phase);

	     src_sqrh = new[m_cfg.no_of_src_agent];
	     dst_sqrh = new[m_cfg.no_of_dst_agent];
    		
	endfunction

endclass

