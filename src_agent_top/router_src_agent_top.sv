class router_src_agt_top extends uvm_component;
 // Factory Registration
	`uvm_component_utils(router_src_agt_top)
  
   // Create the agent handle
      	router_src_agent sagnth[];

	router_env_config m_cfg;

//-----------------  constructor new method  -------------------//
   	function new(string name = "router_src_agt_top" , uvm_component parent);
		super.new(name,parent);
	endfunction

    
//-----------------  build() phase method  -------------------//
       	virtual function void build_phase(uvm_phase phase);
	     if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
	     	  `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

     	      super.build_phase(phase);

	     if(m_cfg.has_src_agent) 
	      begin
		  sagnth = new[m_cfg.no_of_src_agent];

		  foreach(sagnth[i])
		    begin
		      uvm_config_db #(router_src_agent_config)::set(this,$sformatf("sagnth[%0d]*",i),"router_src_agent_config",m_cfg.m_src_agent_cfg[i]);
		      sagnth[i]=router_src_agent::type_id::create($sformatf("sagnth[%0d]",i),this);
		    end
	     end
	endfunction
 endclass

