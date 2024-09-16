import re
import sys
import argparse
import tempfile

########################################
# Find the ports and the parameters in #
# the module we want to instantiate    # 
########################################

def find_ports(inst_file):

    module_name = None
    ports       = []        # It is a list, where input, output and inout will be stored.
    parameters  = []
    
    with open(inst_file, "r") as file:
        lines = file.readlines()     # Read the file and make each line an item in the list 'lines'
        lines_iter = iter(lines)     # Make it an iterator for the for-loop.
        for line in lines_iter:
            line = line.strip()      # Strip the lines items from whitespace.
            if "/*" in line:         # Avoid comments in the file where the word module is mentioned. 
                match = ""
            elif "module" in line:                              
                match = re.search(r'module\s+(\w+)', line)  # Search for module name. A match to the regex pattern provided as the first argument. In .group(1), the first capturing object
                if match:                                   # (as stated by the (\+w)) is saved. In this case, that is the module name.
                    module_name = match.group(1)            # If there's a match, extract the module name. If not, module_name will be empty (executes line 46).
                    
            if "parameter" in line:                                        
                param = re.findall(r'\b\w+\b', line.split("parameter")[-1])  # line.split(): This splits the string line into a list of substrings, based on the word "parameter".
                parameter_names = [param[0]]                                 # line.split()[-1] -> gives the last element of the list (the last substring, here everything that follows after "parameter").                                                  
                parameters.extend(parameter_names)                           # re.findall -> finds all the words, so now param is a list of the words after the keyword "parameter"
                                                                             # param[0] -> gives the first element, which is the parameter name.
            port_names   = ""
            
            port_declaration = line.strip().startswith(("input", "output", "inout"))  # Is true only when a port is included in the design. If the line doesn't start with whistespace 
            if port_declaration:                                                      # and the keyword input, output or inout, but does include them somewhere, then the port has been
                                                                                      # commented out and should not be included in the instantiation.
                port_section = ""
                                                                        
                port_section = line.split(",")[0]                 # Split the line at the comma and take the firts element (the substring before the comma).  
                port_names = port_section.split()[-1]             # Split the line based on whitespace, so we have a list with the last element being the port_name. With the [-1] index, we extract it. 
                                                                                                   
      
                ports.append(port_names)                # .append(port_names): It's a method that adds all elements of port_names (which is a list) to the list ports. 
                                                        #  So, now the port names are all saved in the list. 
       
                                                         
    if module_name is None:
        print("No module name found in the file. Please check the file content.")  
        
    words_to_remove = ["wrapper", "top"]
    
    for name in module_name:
        plain_module_name = remove_from_string(module_name, words_to_remove)    # Just the module name, without any additional words like top or wrapper. 
                                                                                # We will use it for cteating the wires.
  
    #For debugging
    #print(f"Port section: {port_section}")
    #print(f"Extracted port names: {port_names}")
    return module_name, parameters, ports, plain_module_name


##############################
#   Functions for exrtacting #
#   part of a string         #
##############################

def remove_from_string(word, substrings):      
    for substring in substrings:
        word = word.replace(substring, "").rstrip("_")                
    
    return word
  

###############################################
#    Create the clock and reset wires (lists) #   
###############################################

def create_clk_wires(wrapper_file, ports, module_name):

    with open(wrapper_file, "a") as file:
    
        #Clocks
        
        clk_ports = [port for port in ports if re.search(r"clk", port, re.IGNORECASE)]         # It is a list, even if it has only one item.
        
        for clk_port in clk_ports:
            file.write(f"   wire {clk_port}_{plain_module_name};\n")          # Wire declarations.
        #print(f" clk of {module_name} : {clk_ports}")    
    return clk_ports                 
     
     
def create_reset_wires(wrapper_file, ports, module_name):  
      
        #Reset signals
    with open(wrapper_file, "a") as file:    
    
        reset_names = ["rst_n", "reset_n", "rstn", "reset"]
        
        n_reset_ports = [port for port in ports if any(re.search(reset_name, port, re.IGNORECASE) for reset_name in reset_names)]
        
        for reset_port in n_reset_ports:
            file.write(f"   wire {reset_port}_{plain_module_name};\n")
        #print(f" reset of {module_name} : {n_reset_ports}")    
    return n_reset_ports
         

def clk_assignments(wrapper_file, clk_ports, plain_module_name):
    with open(wrapper_file, "a") as file:
        for clk_port in clk_ports:
            file.write(f"   assign {plain_module_name}_{clk_port} = clk;\n")  # Assign the clock and reset signals to the clk and rstn input ports (of the wrapper).
               
               
def reset_assignments(wrapper_file, n_reset_ports, plain_module_name):
    with open(wrapper_file, "a") as file:
        for reset_port in n_reset_ports:
            file.write(f"   assign {plain_module_name}_{reset_port} = rstn;\n")
  
  
##################################
#  Create temp files for writing #
#  the clk and reset wires and   #
#  assignments in the wrapper    #
##################################

def write_temp_files(clk_ports, n_reset_ports, plain_module_name):

    clk_wires_temp = tempfile.TemporaryFile(mode='w+t')          #a method call from the tempfile module. The TemporaryFile() function creates and returns a temporary file object. This temporary file can be used as a regular file object but is automatically deleted when closed or when the program exits.
    reset_wires_temp = tempfile.TemporaryFile(mode='w+t')
    clk_assign_temp = tempfile.TemporaryFile(mode='w+t')
    reset_assign_temp = tempfile.TemporaryFile(mode='w+t')
    
    for clk in clk_ports:
            clk_wires_temp.write(f"    wire {clk}_{plain_module_name};\n")
            clk_assign_temp.write(f"    assign {clk}_{plain_module_name} = clk;\n")
            
    for rst in n_reset_ports:
            reset_wires_temp.write(f"   wire {rst}_{plain_module_name};\n")
            reset_assign_temp.write(f"  assign {rst}_{plain_module_name} = rstn; \n")
    
    clk_wires_temp.seek(0)                                    #rewind the files' cursor at the beginning, for reading
    clk_assign_temp.seek(0)
    reset_wires_temp.seek(0)
    reset_assign_temp.seek(0)
    
    #For debugging
   # print("clk_wires_temp content:", clk_wires_temp.read())
    #print("reset_wires_temp content:", reset_wires_temp.read())
    #print("clk_assign_temp content:", clk_assign_temp.read())
   # print("reset_assign_temp content:", reset_assign_temp.read())
    
    return clk_wires_temp, clk_assign_temp, reset_wires_temp, reset_assign_temp


###############################
#   Write in the wrapper the  #
#  contents of the temp files #
###############################

def write_clk_and_rst_to_wrapper(wrapper_file, clk_wires_temp, clk_assign_temp, reset_wires_temp, reset_assign_temp):
    with open(wrapper_file, "a") as file:
        
        file.write(clk_wires_temp.read())
        file.write(reset_wires_temp.read())
        file.write("\n")
        file.write(clk_assign_temp.read())
        file.write("\n")
        file.write(reset_assign_temp.read())
        file.write("\n\n")
        
    clk_wires_temp.close()
    reset_wires_temp.close()
    clk_assign_temp.close()
    reset_assign_temp.close()
       
######################################
#    Create the rest of the wires    #
#   with the appropriate bit range   #
######################################

#def create_modules_wires(wrapper_file, ports, parameters, module_name):
#
#    with open(wrapper_file, "a") as file:
#        file.write(f"/*###########################################################*/\n")           #FIX SYMMETRY OF THE TITLE COMMENT
#        file.write(f"/*                 {plain_module_name} Interface             */\n")
#        file.write(f"/*                          (Vtool)                          */\n")
#        file.write(f"/*###########################################################*/\n")   
#    
#    for 

############################
# Create the instantiation #
#      in soc_wrapper      # 
############################

def create_inst_in_wrapper(wrapper_file, module_name, ports, parameters):
    with open(wrapper_file, "a") as file:
        file.write(f"/*###########################################################*/\n")           #FIX SYMMETRY OF THE TITLE COMMENT
        file.write(f"/*                 {plain_module_name}                       */\n")
        file.write(f"/*###########################################################*/\n")
        
        file.write(f"{module_name}\n ")                    # Write module name
        
        if parameters:                                      #If the parameters list is not empty, the condition is true.
        
            file.write(f"#(\n")
            
            for i, parameter in enumerate(parameters): 
                if i == len(parameters) - 1:                   # Check if it's the last parameter
                    file.write(f"       .{parameter}()\n")     # No comma at the end
                else:
                    file.write(f"       .{parameter}(),\n")    # Comma for all other ports
            file.write(f")\n")                           
            
            file.write(f"{module_name}_inst (\n")              # Write instance name
        
         
        for i, port in enumerate(ports): 
            if i == len(ports) - 1:                        # Check if it's the last port
                file.write(f"        .{port}({port})\n")   # No comma at the end
            else:
                file.write(f"        .{port}({port}),\n")  # Comma for all other ports
                
        file.write(");\n\n")                               # Close instantiation


############################################
#   Run the script from the command line.  #
# Insert the necessary files as arguments. # 
############################################


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description = "Interconnect instantiation script")      
    parser.add_argument("-t", "--top", help = "Path to the TOP wrapper *.sv file")
    parser.add_argument("-i", "--inst", help = "Path to the file you want to instantiate in the wrapper module")
    args = parser.parse_args()
    
    if args.top == None:
        print("Add the path to the TOP file.")
        exit()
    elif not args.top.endswith((".sv", ".v")):
        print("The wrapper file must have a *.sv or *.v extension.")
        exit()

    if args.inst == None:
        print("Add the path of the module you want to instantiate")
        exit()
    elif not args.inst.endswith((".txt")):
        print("The filelist file must have a *.txt extension.")
        exit()
    else:
        wrapper_file = args.top
        inst_file    = args.inst
        modules_to_instantiate = args.inst
  
    #module_name, parameters, ports, plain_module_name = find_ports(inst_file)
    #create_clk_and_reset_wires(wrapper_file, ports, module_name)
    #create_modules_wires(wrapper_file, ports, parameters, module_name)
    #create_inst_in_wrapper(wrapper_file, module_name, ports, parameters)

    with open(modules_to_instantiate, "r") as file:
        lines = file.readlines()
    
    open(wrapper_file, "w").close()                                             # Delete previous contents of the wrapper file.
    
    with open(wrapper_file, "a") as file:
        file.write(f"/*###########################################################*/\n")
        file.write(f"/*                 Clock and reset assign                    */\n")
        file.write(f"/*                                                           */\n")
        file.write(f"/*###########################################################*/\n")
        file.write(f"\n")
    
    with open(wrapper_file, "a") as file:
        for line in lines:
            line = line.strip()
            inst_file = line
            module_name, parameters, ports, plain_module_name = find_ports(inst_file) 
            clk_ports = create_clk_wires(wrapper_file, ports, module_name)    #List of all the clock signals (from the modules we want to instantiate)
           
        for line in lines:
            line = line.strip()
            inst_file = line
            module_name, parameters, ports, plain_module_name = find_ports(inst_file)
            n_reset_ports = create_reset_wires(wrapper_file, ports, module_name)
        
    clk_wires_temp, clk_assign_temp, reset_wires_temp, reset_assign_temp = write_temp_files(clk_ports, n_reset_ports, plain_module_name)
    write_clk_and_rst_to_wrapper(wrapper_file, clk_wires_temp, clk_assign_temp, reset_wires_temp, reset_assign_temp)
    
    clk_wires_temp.close()
    reset_wires_temp.close()
    clk_assign_temp.close()
    reset_assign_temp.close()
          
    with open(wrapper_file, "a") as file:    
        for line in lines:
            line = line.strip()
            inst_file = line
            module_name, parameters, ports, plain_module_name = find_ports(inst_file)     
            clk_assignments(wrapper_file, clk_ports, plain_module_name)
    
    with open(wrapper_file, "a") as file:
        file.write(f"\n")
        
    with open(wrapper_file, "a") as file:    
        for line in lines:
            line = line.strip()
            inst_file = line
            module_name, parameters, ports, plain_module_name = find_ports(inst_file)     
            reset_assignments(wrapper_file, n_reset_ports, plain_module_name)
            
    with open(wrapper_file, "a") as file:
        file.write(f"\n")
        
    with open(wrapper_file, "a") as file:    
        for line in lines:
            line = line.strip()
            inst_file = line
            module_name, parameters, ports, plain_module_name = find_ports(inst_file)
            create_inst_in_wrapper(wrapper_file, module_name, ports, parameters)

