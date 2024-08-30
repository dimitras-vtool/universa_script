import re
import sys
import argparse

########################################
# Find the ports and the parameters in #
# the module we want to instantiate    # 
########################################

def find_ports(inst_file):

    module_name = None
    ports       = []        #It is a list, where input, output and inout will be stored.
    parameters  = []
    
    with open(inst_file, "r") as file:
        lines = file.readlines()     # Read the file and make each line an item in the list 'lines'
        lines_iter = iter(lines)     # Make it an iterator for the for-loop.
        for line in lines_iter:
            line = line.strip()      # Strip the lines items from whitespace.
            if "module" in line:                              
                match = re.search(r'module\s+(\w+)', line)  # Search for module name. A match to the regex pattern provided as the first argument. In .group(1), the first capturing object
                if match:                                   # (as stated by the (\+w)) is saved. In this case, that is the module name.
                    module_name = match.group(1)            # If there's a match, extract the module name. If not, module_name will be empty (executes line 46).
                    
            if "parameter" in line:                                        
                param = re.findall(r'\b\w+\b', line.split("parameter")[-1])  #line.split(): This splits the string line into a list of substrings, based on the word "parameter".
                parameter_names = [param[0]]                                 #line.split()[-1] -> gives the last element of the list (the last substring, here everything that follows after "parameter").                                                  
                parameters.extend(parameter_names)                           #re.findall -> finds all the words, so now param is a list of the words after the keyword "parameter"
                                                                             #param[0] -> gives the first element, which is the parameter name.
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
        
    #For debugging
    print(f"Port section: {port_section}")
    print(f"Extracted port names: {port_names}")
    return module_name, parameters, ports


############################
# Create the instantiation #
#      in soc_wrapper      # 
############################

def create_inst_in_wrapper(wrapper_file, module_name, ports, parameters):
    with open(wrapper_file, "a") as file:
        file.write(f"   {module_name}\n ")     # Write module name
        file.write(f"   #(\n")
        
        for i, parameter in enumerate(parameters): 
            if i == len(parameters) - 1:  # Check if it's the last parameter
                file.write(f"       .{parameter}()\n")   # No comma at the end
            else:
                file.write(f"       .{parameter}(),\n")  # Comma for all other ports
        file.write(f"   )\n")                           
        
        file.write(f"   {module_name}_inst (\n")             # Write instance name
        
         
        for i, port in enumerate(ports): 
            if i == len(ports) - 1:  # Check if it's the last port
                file.write(f"        .{port}()\n")   # No comma at the end
            else:
                file.write(f"        .{port}(),\n")  # Comma for all other ports
                
        file.write("    );\n\n")                           # Close instantiation


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
        print("The file must have a *.sv or *.v extension.")
        exit()

    if args.inst == None:
        print("Add the path of the module you want to instantiate")
        exit()
    elif not args.inst.endswith((".sv", ".v")):
        print("The file must have a *.sv or *.v extension.")
        exit()
    else:
        wrapper_file = args.top
        inst_file    = args.inst
        
    module_name, parameters, ports = find_ports(inst_file)
    create_inst_in_wrapper(wrapper_file, module_name, ports, parameters)


#Kάνε path με variables

