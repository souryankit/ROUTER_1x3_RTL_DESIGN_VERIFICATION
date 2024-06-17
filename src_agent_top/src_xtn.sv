class src_xtn extends uvm_sequence_item;

	`uvm_object_utils(src_xtn)
	
	rand bit [7:0] header;
	rand bit [7:0] pl[];
	bit [7:0] parity;
	bit error;

	function new(string name = "src_xtn");
		super.new(name);
	endfunction

	constraint c_addr{header[1:0] != 2'b11;}
	constraint c_pl_size{pl.size ==header[7:2];}
	constraint c3{header[7:2] != 0;}
	


		//do_copy
	function void do_copy (uvm_object rhs);

    		// handle for overriding the variable
    		src_xtn rhs_;

		//check the compatibility
    		if(!$cast(rhs_,rhs)) 
			begin
   				`uvm_fatal("do_copy","cast of the rhs object failed")
    			end

    		super.do_copy(rhs);

  		// Copy over data members:
  		// <var_name> = rhs_.<var_name>;
    		header= rhs_.header;
    		pl= new[header[7:2]];
		foreach(pl[i])
			pl[i]=rhs_.pl[i];
    		parity= rhs_.parity;
    		error= rhs_.error;
	
  	endfunction:do_copy


 	function void  do_print (uvm_printer printer);
    		super.do_print(printer);
   	 //                       srting name   		bitstream value     size       radix for printing
    		printer.print_field( "header", 			this.header, 	    8,		 UVM_BIN	);
	     foreach(pl[i])
    		printer.print_field($sformatf("pl[%0d]",i), 	this.pl[i], 	    8,		 UVM_DEC	);
    		printer.print_field( "parity", 			this.parity, 	    8,		 UVM_DEC	);
     endfunction:do_print
   
	function void post_randomize();
		parity = header ^ 0;
		foreach(pl[i])
			parity = parity ^ pl[i];
	endfunction

endclass

