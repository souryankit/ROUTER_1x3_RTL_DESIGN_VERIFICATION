class router_dst_agt_top extends uvm_component;

     `uvm_component_utils(router_dst_agt_top)
      
      router_dst_agent dagnth[];

      router_env_config m_cfg;

//-----------------  constructor new method  -------------------//
   	function new(string name = "router_dst_agt_top" , uvm_component parent);
		super.new(name,parent);
	endfunction

    
//-----------------  build() phase method  -------------------//
       	virtual function void build_phase(uvm_phase phase);
	     if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
	     	  `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

     	      super.build_phase(phase);

	      if(m_cfg.has_dst_agent) begin
		   dagnth = new[m_cfg.no_of_dst_agent];

		   foreach(dagnth[i]) 
		      begin
                  	uvm_config_db #(router_dst_agent_config)::set(this,$sformatf("dagnth[%0d]*",i),"router_dst_agent_config",m_cfg.m_dst_agent_cfg[i]);
   			dagnth[i]=router_dst_agent::type_id::create($sformatf("dagnth[%0d]",i),this);
		end
	      end
	endfunction

 endclass

