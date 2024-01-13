# reverse-shell-C2 README
## Overview
This project comprises two PowerShell scripts: a reverse shell script and a listener script, designed for use in red team exercises and testing detection capabilities. In a red team exercise, the reverse shell script simulates an attacker's method of gaining remote access to a target system, while the listener script represents the attacker's control server. 

### Applications in Red Team Exercises
- **Simulating Attack Scenarios**: The reverse shell script can be deployed in a controlled environment to mimic the actions of an attacker who has infiltrated a network.
- **Testing Network Defenses**: By deploying the reverse shell, red teams can test the effectiveness of network defenses and incident response procedures.
- **Detection and Response**: The listener and reverse shell interaction provides a scenario for blue teams to practice detecting and mitigating such threats.

## How to Run

### Running the Listener Script

1. **Open PowerShell**: On the controller machine, open PowerShell. Ensure you have administrative or appropriate execution privileges.

2. **Navigate to Script Location**: Use the `cd` command to navigate to the directory where the listener script is located.

3. **Execute the Listener Script**: Run the listener script by typing `.\listener_script.ps1` (replace `listener_script.ps1` with the actual script filename).

4. **Monitor for Connections**: Once the listener script is running, it will display a message indicating it's listening for connections. Keep this terminal open to monitor incoming data and to issue commands.

### Running the Reverse Shell Script

1. **Prepare the Target Machine**: On the target machine, where you want the reverse shell to operate, open PowerShell with appropriate privileges.

2. **Navigate to the Script Location**: Change to the directory where the reverse shell script is stored.

3. **Update the Script Configuration**: Before running the script, make sure to edit the `$IPAddress` and `$Port` variables to point to the controller machine's IP address and the chosen port number.

4. **Execute the Reverse Shell Script**: Run the script by typing `.\reverse_shell_script.ps1` (replace `reverse_shell_script.ps1` with the actual filename).

5. **Confirm Connection**: On the controller machine, you should see a notification of an established connection in the PowerShell window where the listener script is running.

### Interaction Between Listener and Reverse Shell

- **Sending Commands**: In the listener script's PowerShell window, you can type commands and press Enter to send them to the reverse shell.
- **Receiving Data**: The reverse shell script will send data back to the listener, including the output of executed commands and any files specified in the script.
