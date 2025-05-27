import os
import pathlib

# Define the source directory and output file
src_directory = pathlib.Path().resolve()
output_file = "prompt.txt"

# File extensions to include
valid_extensions = {".php", ".html", ".js", ".css",".xojo_code",".json",".lua"}

# Initialize output content
output_content = """I need your help with my current project, here are the files I have so far

"""

# Walk through all files in src and subdirectories
for root, _, files in os.walk(src_directory):
    for file in files:
        #Check if node_modules is in FilePath if so ignore
        if "node_modules" in os.path.join(root, file):
            continue
        if file == "package-lock.json":
            continue
        if file == "package.json":
            continue
        #Check if file is tailwind.css if it is ignore
        if file == "tailwind.css":
            continue
        if file== "chart.js":
            continue
        file_path = os.path.join(root, file)
        file_extension = os.path.splitext(file)[1].lower()
        
        if file_extension in valid_extensions:
            try:
                with open(file_path, "r", encoding="utf-8") as f:
                    content = f.read()
                
                # Add file content in required format
                extension = "xojo" if file_extension == ".xojo_code" else file_extension[1:]
                output_content += f"{{{file_path}}}\n```{extension}\n{content}\n```\n\n"
            except Exception as e:
                print(f"Skipping {file_path} due to error: {e}")

# Append final instruction
output_content += "When editing a file make sure you output the entire file not just the changes so I can copy and paste them, for xojo files output each function in a unique code block"

output_content += """
I need help with my current Project it is an implementation of a FSD Server in Xojo, A FSD Server is a multiplayer server for
Flight Simuation where Pilots and Air Traffic Controllers can connect to the server and play a game of Flight Simulator.

I need you to convert the following cpp code of the original FSD Server to Xojo code. Answer in neatly formatted markdown. with each function or sub in  
a separate code block. Thank you for your help.
Here is the C++ Code:
"""
# Write to the output file
with open(output_file, "w", encoding="utf-8") as f:
    f.write(output_content)

print(f"Merged files into {output_file}")
