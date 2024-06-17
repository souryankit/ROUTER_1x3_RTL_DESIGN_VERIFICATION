// extend router_env_config from uvm_object

class router_env_config extends uvm_object;

`uvm_object_utils(router_env_config)

bit has_functional_coverage = 1;
//bit has_functional_coverage = 0;
bit has_scoreboard = 1;

bit has_src_agent = 1;
bit has_dst_agent = 1;
int no_of_src_agent = 1;
int no_of_dst_agent = 3;

bit has_virtual_sequencer = 1;

router_src_agent_config m_src_agent_cfg[];
router_dst_agent_config m_dst_agent_cfg[];

int no_of_duts =1;

// Standard UVM Methods:
	function new(string name = "router_env_config");
		 super.new(name);
	endfunction


endclass: router_env_config

