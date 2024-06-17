//------------------------------------------
// DESTINATION BASE SEQUENCE CLASS
//------------------------------------------

class router_dst_seqs extends uvm_sequence#(dst_xtn);

	//factory registration
	`uvm_object_utils(router_dst_seqs)

	//overriding constructor
	function new(string name="router_dst_seqs");
		super.new(name);
	endfunction

endclass

//------------------------------------------
// DESTINATION IDEAL SEQUENCE CLASS
//------------------------------------------

class router_dst_ideal extends router_dst_seqs;

	//factory registration
	`uvm_object_utils(router_dst_ideal)

	//overriding constructor
	function new(string name="router_dst_ideal");
		super.new(name);
	endfunction

	//body
	task body();
	
		//create instance of transaction class
		req=dst_xtn::type_id::create("req");
	
		start_item(req);
	
		assert(req.randomize() with{no_of_cycles inside {[1:20]};});
		//`uvm_info("ROUTER_DEST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)

		finish_item(req);
	
	endtask

endclass

//------------------------------------------
// DESTINATION SOFT RESET SEQUENCE CLASS
//------------------------------------------

class router_dst_soft_rst extends router_dst_seqs;

	//factory registration
	`uvm_object_utils(router_dst_soft_rst)

	//overriding constructor
	function new(string name="router_dst_soft_rst");
		super.new(name);
	endfunction

	//body
	task body();

		//create instance of transaction class
		req=dst_xtn::type_id::create("req");

		//wait for driver to request item
		start_item(req);

		//randomize 
		assert(req.randomize() with{no_of_cycles == 30;});
		`uvm_info("ROUTER_DEST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)

		//send randomize items and wait for acknowledement
		finish_item(req);

	endtask

endclass


/*
class router_dst_seqs extends uvm_sequence #(dst_xtn);

	`uvm_object_utils(router_dst_seqs)

	function new (string name = "router_dst_seqs");
	super.new(name);
	endfunction

	
	task body();
    	repeat(2)
	  begin
   	   req=dst_xtn::type_id::create("req");
	   start_item(req);
   	   assert(req.randomize() with {no_of_cycles inside{[1:28]};});
	   `uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_NONE) 

	   finish_item(req);
	   end
    	endtask
endclass
*/


