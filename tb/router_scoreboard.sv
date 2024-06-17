//------------------------------------------
// SCOREBOARD CLASS
//------------------------------------------

class router_scoreboard extends uvm_scoreboard;

	//factory registration
	`uvm_component_utils(router_scoreboard)

	//tlm analysis fifo declaration
	uvm_tlm_analysis_fifo #(src_xtn) fifo_src;
	uvm_tlm_analysis_fifo #(dst_xtn) fifo_dst[];
	
	//declare env config handle
	router_env_config m_env_cfg;

	//declare transaction class
	src_xtn sxtn;
	dst_xtn dxtn;
	
	//source covergroup
	covergroup src_cg;
		option.per_instance=1;

		addr : coverpoint sxtn.header[1:0]{illegal_bins IB = {2'b11};}
		len : coverpoint sxtn.header[7:2]{bins low = {[1:16]};
						  bins med = {[17:40]};
						  bins lrg = {[41:63]};}
		err: coverpoint sxtn.error ;

		ADDRXLEN : cross addr,len;
	endgroup	
	covergroup src_cg1 with function sample(int i);
		option.per_instance=1;
	
		pyld : coverpoint sxtn.pl[i]{
bins low = {[0:50]};
					      bins low1 = {[51:100]};
					      bins med = {[101:150]};
					      bins lrg = {[151:200]};
					      bins lrg1 = {[201:255]};}
	endgroup

	//dst_covergroup
	covergroup dst_cg;
		option.per_instance=1;

		addr : coverpoint dxtn.header[1:0]{illegal_bins IB = {2'b11};}
		len : coverpoint dxtn.header[7:2]{bins low = {[1:16]};
						  bins med = {[17:40]};
						  bins lrg = {[41:63]};}
		ADDRXLEN : cross addr,len;
	endgroup
	covergroup dst_cg1 with function sample(int i);
		option.per_instance=1;
	
		pyld : coverpoint dxtn.pl[i]{bins low = {[0:50]};
					     bins low1 = {[51:100]};
					     bins med = {[101:150]};
					     bins lrg = {[151:200]};
					     bins lrg1 = {[201:255]};}
	endgroup

	//overriding constructor
	function new(string name,uvm_component parent = null);
		super.new(name,parent);
		src_cg = new();
		src_cg1 = new();
		dst_cg = new();

//------------------------------------------
// BASE TEST CLASS
//------------------------------------------

/*
class router_base_test extends uvm_test;

	//factory registration
	`uvm_component_utils(router_base_test)
	
	//declare env handle
	router_env envh;
	
	//declare env,dest_agent,source_agent config handles and addr
	router_env_config m_env_cfg;
	router_dest_agent_config m_dest_cfg[];
	router_source_agent_config m_source_cfg;
	bit[1:0] addr = 0;

	//assign value for has_dest_agent,has_source_agent,no_of_dest_config,no_of_source_config 
	bit has_dest_agent = 1;
	bit has_source_agent = 1;
	int no_of_dest_config = 3;
		
	//overriding constructor
	function new(string name,uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	//Build_phase
	virtual function void build_phase(uvm_phase phase);
		
		//create env_config instance
		m_env_cfg=router_env_config::type_id::create("m_env_cfg");
		
		//assign parameter to env_config
		if(has_source_agent)
			begin
				//create instance for source config 
				m_source_cfg=router_source_agent_config::type_id::create("m_source_cfg");

				//assign parameters for source config
				if(!uvm_config_db#(virtual src_if)::get(this,"","src_if",m_source_cfg.vif))
					`uvm_fatal("CONFIG","cannot get() virtual interface from uvm_config_db. Have you set() it?")
				m_source_cfg.is_active = UVM_ACTIVE;
						
				//assign source config to env's source config
				m_env_cfg.m_source_cfg = m_source_cfg;
			end
		if(has_dest_agent)
			begin
				
				//assign dynamic array size for dest_config
				m_env_cfg.m_dest_cfg = new[no_of_dest_config];
				m_dest_cfg = new[no_of_dest_config];
				foreach(m_dest_cfg[i])
					begin
						
						//create instance for dest config
						m_dest_cfg[i]=router_dest_agent_config::type_id::create($sformatf("m_dest_cfg[%0d]",i));
						
						//assign parameters for dest config
						if(!uvm_config_db#(virtual dst_if)::get(this,"",$sformatf("dst_if%0d",i),m_dest_cfg[i].vif))
							`uvm_fatal("CONFIG","cannot get() virtual interface from uvm_config_db. Have you set() it?")
						m_dest_cfg[i].is_active = UVM_ACTIVE;
						
						//assign dest config to env's dest config
						m_env_cfg.m_dest_cfg[i] = m_dest_cfg[i];
					end
			end
			
		//assign has_dest_agent,has_source_agent,no_of_dest_config,no_of_source_config to env's has_dest_agent,has_source_agent,no_of_dest_config,no_of_source_config
		m_env_cfg.has_dest_agent = has_dest_agent;
		m_env_cfg.has_source_agent = has_source_agent;
		m_env_cfg.no_of_dest_config = no_of_dest_config ;

		//set env_config
		uvm_config_db#(router_env_config)::set(this,"*","router_env_config",m_env_cfg);
		
		super.build_phase(phase);

		//create env instance
		envh = router_env::type_id::create("envh",this);
		
	endfunction

	//print topology
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		
		//randomize addr
		addr = {$urandom}%3;
		
		//set config for addr
		uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);

	endtask

endclass

*/		dst_cg1 = new();
	endfunction
	
	//build_phase
	virtual function void build_phase(uvm_phase phase);
		
		//get env_config 
		if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",m_env_cfg))
			`uvm_fatal("CONFIG","cannot get() m_env_cfg from uvm_config_db. Have you set() it?") 

		//assign dynamic array size of tlm analysis fifo
		fifo_dst = new[m_env_cfg.no_of_dst_agent];

		// create tlm analysis fifo
		fifo_src = new("fifo_src",this);
		foreach(fifo_dst[i])
			fifo_dst[i] = new($sformatf("fifo_dst[%0d]",i),this);
		

	endfunction

	//run_phase	
	task run_phase(uvm_phase phase);
		forever
			begin
				fifo_src.get(sxtn);
				foreach(fifo_dst[i])
					begin
						if(sxtn.header[1:0] == i)
							fifo_dst[i].get(dxtn);
					end
				compare();
				src_cg.sample();
				foreach(sxtn.pl[i])
					src_cg1.sample(i);

				dst_cg.sample();
				foreach(sxtn.pl[i])
					dst_cg1.sample(i);
			end
	endtask
        
	//task compare
	task compare();
		if(sxtn.header == dxtn.header)
			`uvm_info("COMPARE","Header is successfully compared",UVM_LOW)
		else
			`uvm_fatal("COMPARE","Header is not compared successfully")
		if(sxtn.pl == dxtn.pl)
			`uvm_info("COMPARE","Payload is successfully compared",UVM_LOW)
		else
			`uvm_fatal("COMPARE","Payload is not compared successfully")
		if(sxtn.parity == dxtn.parity)
			`uvm_info("COMPARE","Parity is successfully compared",UVM_LOW)
		else
			`uvm_fatal("COMPARE","Parity is not compared successfully")
	endtask
					
endclass

