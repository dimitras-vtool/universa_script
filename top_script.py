import re
import sys
import argparse

########################################
# Find the ports and the parameters in #
# the module we want to instantiate    # 
########################################

def find_ports(inst_file):

    module_name = None
    ports = []        #It is a list, where input, output and inout will be stored.
    parameters = []
    
    with open(inst_file, "r") as file:
        lines = file.readlines()     # Read the file and make each line an item in the list 'lines'
        lines_iter = iter(lines)
        for line in lines_iter:
            line = line.strip()      # Strip the lines items from whitespace
            if "module" in line:                                           # The re.search function searches the string line for 
                match = re.search(r'module\s+(\w+)', line)                 # Search for module name. A match to the regex pattern provided as the first argument. In .group(1) the first capturing object
                if match:                                                  # (as stated by the (\+w)) is saved. In this case that is the module name.
                    module_name = match.group(1)                           # If there's a match, extract the module name
                    
            if "parameter" in line:                                        
                param = re.findall(r'\b\w+\b', line.split("parameter")[-1])  
                parameter_names = [param[0]]
                parameters.extend(parameter_names)
            
            port_names   = ""
            
            
            if "input" in line or "output" in line or "inout" in line:    #Checks one condition after the other, not at the same time
            #if ("input" or "output" or "inout") in line:  #If the parentheses is TRUE the if block is executed and obviously it doesn't run again. So the outputs and inouts are never written.
            #if not "input" in line and not "output" in line and not "inout" in line: #This along with else : same result as the first if.
                port_section = ""
            #else:
                                                                                
                    
                                                                                
                port_section = line.split("] ")[-1]                                             # [-1]: Retrieves the last element of the list resulting from the split operation.  
                port_names = port_section.split()[0].strip(',')
                #port_names = re.findall(r'\b(\w+)\s*(?:\[.*?\])?\s*(?:,\s*)?', port_section)   #line.split(): This splits the string line into a list of substrings,
                if '//' in port_names:
                    port_names = port_names.split('//')[0].strip()                                                                                
                                                                                                  
                #print(f"{port_names}")
                ports.append(port_names)     # "ports" is a list 
                                                                # .append(port_names): It's a method that adds all elements of port_names (which is a list) to the list ports. So, now the port names are all saved in the list. 
                  
                                                         
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

