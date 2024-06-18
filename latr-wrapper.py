import tkinter as tk
import subprocess

def run_linux_command():
    # Command to execute 'ls' in WSL
    command = "wsl ls"
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    output, error = process.communicate()

    if process.returncode == 0:
        output_text.insert(tk.END, output.decode())
    else:
        output_text.insert(tk.END, "Error: " + error.decode())

# Create the main window
root = tk.Tk()
root.title("Linux Command Wrapper")

# Create a Text widget to display the output
output_text = tk.Text(root, height=10, width=50)
output_text.pack()

# Create a Button to run the command
run_button = tk.Button(root, text="Run ls Command", command=run_linux_command)
run_button.pack()

# Start the GUI event loop
root.mainloop()
