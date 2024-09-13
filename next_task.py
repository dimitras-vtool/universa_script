#def create_clk_wires(wrapper_file, ports, module_name):
#
#    with open(wrapper_file, "a") as file:
#    
#        #Clocks
#        
#        clk_ports = [port for port in ports if re.search(r"clk", port, re.IGNORECASE)]         # It is a list, even if it has only one item.
#        
#        for clk_port in clk_ports:
#            file.write(f" wire {clk_port}_{plain_module_name};\n")          # Wire declarations.
#            
#    return clk_ports                 
#     
#     
#def create_reset_wires(wrapper_file, ports, module_name):  
#      
#        #Reset signals
#    with open(wrapper_file, "a") as file:    
#    
#        reset_names = ["rst_n", "reset_n", "reset"]
#        
#        n_reset_ports = [port for port in ports if any(reset_name in port.lower() for reset_name in reset_names)]
#        
#        for reset_port in n_reset_ports:
#            file.write(f" wire {reset_port}_{plain_module_name};\n")
#            
#
#    return n_reset_ports
#         
#
#def clk_assignments(clk_ports):
#    with open(wrapper_file, "a") as file:
#        for clk_port in clk_ports:
#            file.write(f" assign {plain_module_name}_{clk_port} = clk;\n")  # Assign the clock and reset signals to the clk and rstn input ports (of the wrapper).
#               
#               
#def reset_assignments(n_reset_ports):
#    with open(wrapper_file, "a") as file:
#        for reset_port in n_reset_ports:
#            file.write(f" assign {plain_module_name}_{reset_port} = rstn;\n")
#






###For mutliple instantiations  
#    
#    with open(modules_to_instantiate, "r") as file:
#        lines = file.readlines()
#        
#    with open(wrapper_file, "a") as file:
#        file.write(f"/*###########################################################*/\n")
#        file.write(f"/*                 Clock and reset assign                    */\n")
#        file.write(f"/*                                                           */\n")
#        file.write(f"/*###########################################################*/\n")
#        file.write(f"\n")
#    
#    with open(wrapper_file, "a") as file:
#        for line in lines:
#            line = line.strip()
#            inst_file = line
#            module_name, parameters, ports, plain_module_name = find_ports(inst_file) 
#            clk_ports = create_clk_wires(wrapper_file, ports, module_name) 
#       
#        for line in lines:
#            line = line.strip()
#            inst_file = line
#            module_name, parameters, ports, plain_module_name = find_ports(inst_file)
#            n_reset_ports = create_reset_wires(wrapper_file, ports, module_name)
#    
#    with open(wrapper_file, "a") as file:
#        file.write(f"\n")
#    
#    with open(wrapper_file, "a") as file:    
#        for line in lines:
#            line = line.strip()
#            inst_file = line
#            module_name, parameters, ports, plain_module_name = find_ports(inst_file)     
#            clk_assignments(clk_ports)
#    
#    with open(wrapper_file, "a") as file:
#        file.write(f"\n")
#        
#    with open(wrapper_file, "a") as file:    
#        for line in lines:
#            line = line.strip()
#            inst_file = line
#            module_name, parameters, ports, plain_module_name = find_ports(inst_file)     
#            reset_assignments(n_reset_ports)
    