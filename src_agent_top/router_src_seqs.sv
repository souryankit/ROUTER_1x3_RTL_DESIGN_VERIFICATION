//------------------------------------------
// SOURCE BASE SEQUENCE CLASS
//------------------------------------------

class router_src_seqs extends uvm_sequence#(src_xtn);

	//factory registration
	`uvm_object_utils(router_src_seqs)

	// declare a parameter to get the data from config db
	bit[1:0] addr;

	//overriding constructor
	function new(string name="router_src_seqs");
		super.new(name);
	endfunction

	task body();

		if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal("CONFIG","cannot get() addr from uvm_config_db. Have you set() it?")

	endtask

endclass

//------------------------------------------
// SOURCE SMALL PACKET SEQUENCE CLASS
//------------------------------------------

class router_source_small_pkt extends router_src_seqs;

	//factory registration
	`uvm_object_utils(router_source_small_pkt)

	//overriding constructor
	function new(string name="router_source_small_pkt");
		super.new(name);
	endfunction
       // bit[1:0] addr = 1;
	//body
	task body();

		super.body();

		begin

		//create instance of transaction class
		req=src_xtn::type_id::create("req");

		//wait for driver to request item
		start_item(req);

		//randomize 
		assert(req.randomize() with{header[7:2] inside {[1:13]}; header[1:0] == addr;});
		`uvm_info("ROUTER_SOURCE_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)

		//send randomize items and wait for acknowledement
		finish_item(req);

		end
	endtask

endclass


//------------------------------------------
// SOURCE MEDIUM PACKET SEQUENCE CLASS
//------------------------------------------

class router_source_medium_pkt extends router_src_seqs;

	//factory registration
	`uvm_object_utils(router_source_medium_pkt)

	//overriding constructor
	function new(string name="router_source_medium_pkt");
		super.new(name);
	endfunction

	//body
	task body();

		super.body();
		
			begin
		//create instance of transaction class
		req=src_xtn::type_id::create("req");

		//wait for driver to request item
		start_item(req);

		//randomize 
		assert(req.randomize() with{header[7:2] inside {[17:40]};header[1:0] == addr;});
		`uvm_info("ROUTER_SOURCE_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)

		//send randomize items and wait for acknowledement
		finish_item(req);
			end
	endtask

endclass

//------------------------------------------
// SOURCE LARGE PACKET SEQUENCE CLASS
//------------------------------------------

class router_source_large_pkt extends router_src_seqs;

	//factory registration
	`uvm_object_utils(router_source_large_pkt)

	//overriding constructor
	function new(string name="router_source_large_pkt");
		super.new(name);
	endfunction

	//body
	task body();

		super.body();

			begin

		//create instance of transaction class
		req=src_xtn::type_id::create("req");

		//wait for driver to request item
		start_item(req);

		//randomize 
		assert(req.randomize() with{header[7:2] inside {[41:63]};header[1:0] == addr;});
		`uvm_info("ROUTER_SOURCE_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)

		//send randomize items and wait for acknowledement
		finish_item(req);
//#100;
			end
	endtask

endclass

//------------------------------------------
// SOURCE RANDOM PACKET SEQUENCE CLASS
//------------------------------------------

class router_source_random_pkt extends router_src_seqs;

	//factory registration
	`uvm_object_utils(router_source_random_pkt)

	//overriding constructor
	function new(string name="router_source_random_pkt");
		super.new(name);
	endfunction

	//body
	task body();

		super.body();

			begin
		//create instance of transaction class
		req=src_xtn::type_id::create("req");

		//wait for driver to request item
		start_item(req);

		//randomize 
		assert(req.randomize() with{header[1:0] == addr;});
		`uvm_info("ROUTER_SOURCE_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)

		//send randomize items and wait for acknowledement
		finish_item(req);

			end

	endtask

endclass


