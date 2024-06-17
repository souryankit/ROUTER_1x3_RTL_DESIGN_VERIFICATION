class dst_xtn extends uvm_sequence_item;

	`uvm_object_utils(dst_xtn)

	rand bit[4:0]no_of_cycles;
	 bit[7:0]header;
	 bit[7:0]pl[];
	 bit[7:0]parity;
	 	

	function new(string name = "dst_xtn");
		super.new(name);
	endfunction
	
		//do_copy
	function void do_copy (uvm_object rhs);

    		// handle for overriding the variable
    		dst_xtn rhs_;

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
    		no_of_cycles= rhs_.no_of_cycles;
	
  	endfunction:do_copy
	

	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("header",				this.header,  		8,	UVM_BIN);
	     foreach(pl[i])
		printer.print_field($sformatf("pl[%0d]",i),		this.pl[i],		8,	UVM_DEC);
		printer.print_field("parity",				this.parity,		8,	UVM_DEC);
		printer.print_field("no_of_cycles",			this.no_of_cycles,	5,	UVM_DEC);
		
	endfunction

endclass
