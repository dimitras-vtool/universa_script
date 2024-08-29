import re
import sys
import argparse

########################################
# Find the ports and the parameters in #
# the module we want to instantiate    # 
########################################

def find_ports(inst_file):

    module_name = None
    ports = {"input": [], "output": [], "inout": []}        #It is a dictionary, where input, output and inout are the keys. The list associated with them are empty here. 
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
                parameter_names = [param[0]]            # Only the first part is the parameter name
                parameters.extend(parameter_names)
            
            port_names   = ""
            
            if "(" in line:
                port_section = line     #Initializes port_section with the current line. This variable will be used to accumulate all lines that are part of the port declaration section.
                while ")" not in line:
                    line = next(lines_iter, "").strip()
                    port_section += " " + line
                port_section += " " + line
                for port_type in ports:                                                                 # The re.finall finds all whole words in the substring obtained after port_type.
                    if port_type in port_section:
                       # port_section = line.split(port_type)[-1]                                       # r'\b\w+\b': This is the regex pattern used to match word sequences.
                        port_names = re.findall(r'\b(\w+)\s*(?:\[.*?\])?\s*(?:,\s*)?', port_section)    #line.split(port_type): This splits the string line into a list of substrings, 
                        #print(f"Extracted port names: {port_names}")                                                                                #using port_type as the delimiter.
                                                                                                        # [-1]: Retrieves the last element of the list resulting from the split operation.  
                        filtered_ports = [name for name in port_names if name not in ports]
                        if filtered_ports:
                            ports[port_type].extend(filtered_ports[-1:])
                        #ports[port_type].extend(port_names)    # "ports" is a dictionary and port_type is a key. So ports[port_type] is the list, stored in the dictionary,                                
                                                                # assocaited with the particular port_type key.
                                                                # .extend(port_names): It's a method that adds all elements of port_names (which is a list) to the list ports[port_type]. So, now the port names are all saved in the list. 
                                                                
           
                                                         
    if module_name is None:
        print("No module name found in the file. Please check the file content.")  
        
    #For debugging
    print(f"Port types: {port_type}")
    print(f"Port section: {port_section}")
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
        
        file.write(f"   {module_name}_inst (\n")         # Write instance name
        
        all_ports = ports["input"] + ports["output"] + ports["inout"] 
        for i, port in enumerate(all_ports): 
            if i == len(all_ports) - 1:              # Check if it's the last port
                file.write(f"        .{port}()\n")   # No comma at the end
            else:
                file.write(f"        .{port}(),\n")  # Comma for all other ports
                
        file.write("    );\n\n")                     # Close instantiation


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

