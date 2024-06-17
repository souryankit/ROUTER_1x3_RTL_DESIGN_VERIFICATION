
class router_base_test extends uvm_test;

   // Factory Registration
	`uvm_component_utils(router_base_test)

    	 router_env router_envh;
         router_env_config m_tb_cfg;
       	 router_src_agent_config m_src_cfg[];
	 router_dst_agent_config m_dst_cfg[];

	// router_src_seqs src_seqh;
	 //router_dst_ideal dst_seqh;

	 bit[1:0] addr =0;

         int no_of_duts = 1;
         int has_src_agent = 1;
         int has_dst_agent = 1;
	 int no_of_src_agent = 1;
	 int no_of_dst_agent = 3;


//-----------------  constructor new method  -------------------//
   	function new(string name = "router_base_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build() phase method  -------------------//

      virtual function void build_phase(uvm_phase phase);
	           m_tb_cfg=router_env_config::type_id::create("m_tb_cfg");

                if(has_src_agent) begin
                   m_tb_cfg.m_src_agent_cfg = new[no_of_src_agent];
		    m_src_cfg = new[no_of_src_agent];
	
	        foreach(m_src_cfg[i]) begin
                  m_src_cfg[i]=router_src_agent_config::type_id::create($sformatf("m_src_cfg[%0d]", i));

  	  	  if(!uvm_config_db #(virtual router_src_if)::get(this,"", $sformatf("svif_%0d",i),m_src_cfg[i].vif))
			`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
                   m_src_cfg[i].is_active = UVM_ACTIVE;
	   // assign the src_agent_config handle to the enviornment config's(ram_env_config) src_agent_config handle
		  m_tb_cfg.m_src_agent_cfg[i] = m_src_cfg[i]; 
                end
	end


                if(has_dst_agent) begin
                   m_tb_cfg.m_dst_agent_cfg = new[no_of_dst_agent];
		   m_dst_cfg = new[no_of_dst_agent];
		
	      foreach(m_dst_cfg[i]) begin
                  m_dst_cfg[i] = router_dst_agent_config::type_id::create($sformatf("m_dst_cfg[%0d]",i));
    		    if(!uvm_config_db #(virtual router_dst_if)::get(this,"", $sformatf("dvif_%0d",i),m_dst_cfg[i].vif))
			`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
               	  m_dst_cfg[i].is_active = UVM_ACTIVE;

	   // assign the dst_agent_config handle to the enviornment config's(ram_env_config) dst_agent_config handle
		   m_tb_cfg.m_dst_agent_cfg[i] = m_dst_cfg[i];
                
                end
        end

  		m_tb_cfg.no_of_duts = no_of_duts;
                m_tb_cfg.has_src_agent = has_src_agent;
                m_tb_cfg.has_dst_agent = has_dst_agent;
		m_tb_cfg.no_of_src_agent = no_of_src_agent;
		m_tb_cfg.no_of_dst_agent = no_of_dst_agent;

                  
	 	uvm_config_db #(router_env_config)::set(this,"*","router_env_config",m_tb_cfg);

     	        super.build_phase(phase);

		router_envh=router_env::type_id::create("router_envh", this);
     endfunction

  
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

/*
	task router_base_test::run_phase(uvm_phase phase);
	  	super.run_phase(phase);
  		 phase.raise_objection(this);
   		 src_seqh=router_src_seqs::type_id::create("src_seqh");
		 dst_seqh=router_dst_ideal::type_id::create("dst_seqh");

		
  	   	src_seqh.start(router_envh.sagt_top.sagnth[0].seqrh);
		
 	        //dst_seqh.start(router_envh.dagt_top.dagnth[1].seqrh);
		//dst_seqh.start(router_envh.dagt_top.dagnth[1].seqrh);
		//dst_seqh.start(router_envh.dagt_top.dagnth[2].seqrh);
	

   		phase.drop_objection(this);
	endtask 

*/

//-----------------------------------------------------------------------
//------------------------------------------------------------------------
//------------------------------------------
// SMALL PACKET TEST CLASS
//------------------------------------------

class router_small_pkt_test extends router_base_test;

	//factory registration
	`uvm_component_utils(router_small_pkt_test)
	
	//declare router_small_pkt_vseq virtual sequence handle
	router_small_pkt_vseq sml_pkt;

	//overriding constructor
	function new(string name,uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);

		//raise objection
        	phase.raise_objection(this);
 		
		//create instance for sequence
          	sml_pkt=router_small_pkt_vseq::type_id::create("sml_pkt");
 		
		//start the sequence wrt virtual sequencer
          	sml_pkt.start(router_envh.v_sequencer);

		#200;
		//drop objection
         	phase.drop_objection(this);
	
	endtask 

endclass


//------------------------------------------
// MEDIUM PACKET TEST CLASS
//------------------------------------------

class router_medium_pkt_test extends router_base_test;

	//factory registration
	`uvm_component_utils(router_medium_pkt_test)
	
	//declare router_medium_pkt_vseq virtual sequence handle
	router_medium_pkt_vseq med_pkt;

	//overriding constructor
	function new(string name,uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
		
		super.run_phase(phase);
 	
		//raise objection
        	phase.raise_objection(this);
 		
		//create instance for sequence
          	med_pkt=router_medium_pkt_vseq::type_id::create("med_pkt");
 		
		//start the sequence wrt virtual sequencer
          	med_pkt.start(router_envh.v_sequencer);
 		
		#200; 

		//drop objection
         	phase.drop_objection(this);
	
	endtask 

endclass

//------------------------------------------
// LARGE PACKET TEST CLASS
//------------------------------------------

class router_large_pkt_test extends router_base_test;

	//factory registration
	`uvm_component_utils(router_large_pkt_test)
	
	//declare router_large_pkt_vseq virtual sequence handle
	router_large_pkt_vseq lrg_pkt;

	//overriding constructor
	function new(string name,uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);

		//raise objection
        	phase.raise_objection(this);
 		
		//create instance for sequence
          	lrg_pkt=router_large_pkt_vseq::type_id::create("lrg_pkt");
 		
		//start the sequence wrt virtual sequencer
          	lrg_pkt.start(router_envh.v_sequencer);
 		
		#200;

		//drop objection
         	phase.drop_objection(this);
	
	endtask 

endclass


//------------------------------------------
// RANDOM PACKET TEST CLASS
//------------------------------------------

class router_random_pkt_test extends router_base_test;

	//factory registration
	`uvm_component_utils(router_random_pkt_test)
	
	//declare router_random_pkt_vseq virtual sequence handle
	router_random_pkt_vseq rand_pkt;

	//overriding constructor
	function new(string name,uvm_component parent = null);
		super.new(name,parent);
		//rand_pkt=router_random_pkt_vseq::type_id::create("rand_pkt");

	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
		
		super.run_phase(phase);
 	
		//raise objection
        	phase.raise_objection(this);

		//create instance for sequence
          	rand_pkt=router_random_pkt_vseq::type_id::create("rand_pkt");
 		
		//start the sequence wrt virtual sequencer
          	rand_pkt.start(router_envh.v_sequencer);
 	
		#200;

		//drop objection
         	phase.drop_objection(this);
	
	endtask   

endclass

//------------------------------------------
// SOFTRESET TEST CLASS
//------------------------------------------

class router_softreset_test extends router_base_test;

	//factory registration
	`uvm_component_utils(router_softreset_test)
	
	//declare router_large_pkt_vseq virtual sequence handle
	router_softreset_vseq sft_rst;

	//overriding constructor
	function new(string name,uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);

		//raise objection
        	phase.raise_objection(this);
 		
		//create instance for sequence
          	sft_rst=router_softreset_vseq::type_id::create("sft_rst");
 		
		//start the sequence wrt virtual sequencer
          	sft_rst.start(router_envh.v_sequencer);
 		
		#200;

		//drop objection
         	phase.drop_objection(this);
	
	endtask 

endclass

/*
//------------------------------------------
// ERROR PACKET TEST CLASS
//------------------------------------------

class router_error_pkt_test extends router_base_test;

	//factory registration
	`uvm_component_utils(router_error_pkt_test)
	
	//declare router_large_pkt_vseq virtual sequence handle
	router_random_pkt_vseq rand_pkt;

	//overriding constructor
	function new(string name,uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//build phase
	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		//override source_xtn class to bad_xtn class
		set_type_override_by_type(source_xtn::get_type(),bad_xtn::get_type());

	endfunction

	//run phase
	task run_phase(uvm_phase phase);
 	
		super.run_phase(phase);

		//raise objection
        	phase.raise_objection(this);
 		
		//create instance for sequence
          	rand_pkt=router_random_pkt_vseq::type_id::create("rand_pkt");
 		
		//start the sequence wrt virtual sequencer
          	rand_pkt.start(router_envh.v_sequencer);
 		
		#200;

		//drop objection
         	phase.drop_objection(this);
	
	endtask 

endclass
*/


