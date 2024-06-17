
class router_env extends uvm_env;

     `uvm_component_utils(router_env)
	
      router_src_agt_top sagt_top;
      router_dst_agt_top dagt_top;
	
      virtual_sequencer v_sequencer;
      router_scoreboard sb;
	
      router_env_config m_cfg;
	
//-----------------  constructor new method  -------------------//
	function new(string name = "router_env", uvm_component parent);
		super.new(name,parent);
	endfunction  

//-----------------  build phase method  -------------------//

    	 virtual function void build_phase(uvm_phase phase);
 
	  if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

         if(m_cfg.has_src_agent) 
	   begin
	      sagt_top = router_src_agt_top::type_id::create("sagt_top",this);
           end

         if(m_cfg.has_dst_agent)
	 begin
	    dagt_top = router_dst_agt_top::type_id::create("dagt_top",this);
         end
         
	super.build_phase(phase);

        if(m_cfg.has_virtual_sequencer) 
	   begin
	        v_sequencer=virtual_sequencer::type_id::create("v_sequencer",this);
           end

	if(m_cfg.has_scoreboard) 
	  begin 
		sb = router_scoreboard::type_id::create("sb",this);
     	  end

	endfunction

//-----------------  connect phase method  -------------------//

	// In connect phase
   	 virtual function void connect_phase(uvm_phase phase);
              if(m_cfg.has_virtual_sequencer)
	   	begin	  

                   if(m_cfg.has_src_agent) 
		     begin
			v_sequencer.src_sqrh[0] = sagt_top.sagnth[0].seqrh;	
	              end

                   if(m_cfg.has_dst_agent) 
		       begin
                         v_sequencer.dst_sqrh[0] = dagt_top.dagnth[0].seqrh;
			 v_sequencer.dst_sqrh[1] = dagt_top.dagnth[1].seqrh;	
			 v_sequencer.dst_sqrh[2] = dagt_top.dagnth[2].seqrh;	
 		       end
                end
	   	    
		   if(m_cfg.has_scoreboard) 
			begin
    			sagt_top.sagnth[0].smonh.monitor_port.connect(sb.fifo_src.analysis_export);

			dagt_top.dagnth[0].monh.monitor_port.connect(sb.fifo_dst[0].analysis_export);
			dagt_top.dagnth[1].monh.monitor_port.connect(sb.fifo_dst[1].analysis_export);
			dagt_top.dagnth[2].monh.monitor_port.connect(sb.fifo_dst[2].analysis_export);

			end
	endfunction

endclass: router_env

