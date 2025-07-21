
---

## Table of Contents

1. [kubegui](#kubegui)
3. [Setup](#setup)
4. [Troubleshooting](#troubleshooting)


---


## kubegui

#### Overview & Version

`kubegui` is a terminal-based tool designed to simplify Kubernetes operations, allowing users to manage configurations, pods, and logs interactively. Its intuitive menu structure guides you through each action step by step.

The current version is 1.0.15

#### Features

- **Interactive Pod Management**: Open a shell in a container, or copy files to/from containers.
- **Namespace-Specific Operations**: Perform actions within a selected namespace.
- **Log Management**: Fetch specific or all logs from containers with ease.
- **Huge File Search**: Search for files larger than 1GB on a selected pod. If no huge files are found, an appropriate message is displayed.
- **Self-Updating**: Check for and install the latest version from the GitHub repository.

#### Menu Structure

The `kubegui` script provides the following menu options:

1. **Open a shell in a container**  
   Select a namespace and pod to open an interactive shell. This allows you to troubleshoot or manage the container directly.  
   Example:
   ```bash
   kubectl exec -it <pod_name> -- /bin/bash
   ```

2. **Copy a file or folder from a container to local**  
   Fetch specific files or directories from a container to your local system. Files are saved in the `~/Downloads/kubegui/` directory, organized by namespace and pod.

3. **Copy a file from local to a container**  
   Upload files or folders from your local machine to a container. Specify the source path on your system and the destination path in the container.

4. **List pods in a namespace**  
   Display all pods in the selected namespace to help you identify resources for further operations.

5. **Download MySQL backups**  
   Locate and download database backup files from the `/var/lib/mysql/backup` directory inside a container. Multiple files can be selected for download.

6. **Download all logs**  
   Fetch all log files from `/var/www/html/storage/log` inside a pod and save them locally. This is useful for debugging applications in Kubernetes.

7. **Download specific log**  
   View a list of available log files in a container, and download selected ones. The logs are saved in the `~/Downloads/kubegui/` directory.

8. **Forward remote Port**  
   Select a namespace and a pod, specify the remote port to forward, and assign a local port on your machine. This allows you to access services running in a Kubernetes pod as if they were running locally. Press `Ctrl+C` to stop the port-forwarding session.

9. **Show huge files**  
   Search for files larger than 1GB on the selected pod. If huge files are found, they are displayed along with their size (in gigabytes). If none are found, a message will indicate that no huge files were detected.

10. **Change config file**  
    Switch between different Kubernetes configuration files located in `~/.config/kubectl/`. This is useful if you manage multiple clusters or contexts.

11. **Update script**  
    Check for the latest version of `kubegui` from the GitHub repository and update automatically. No authentication is required as the repository is public.

- **Exit**  
  You can exit the script at any time by choosing the exit option (typically by entering `q`).

---

## Setup

Follow these steps to install the scripts and make them globally executable:

1. **Run the installer script** to automatically copy scripts from the `scripts` folder to `/usr/local/bin/`:

   ```bash
   sudo ./install-scripts.sh
   ```

2. **Ensure the `scripts` folder exists** in the repository and contains the desired scripts. All files in this folder will be copied.

3. **Run your script** directly from the terminal after installation:

   ```bash
   kubegui
   ```

---

## Troubleshooting

1. If any bash file fails with the message "bad interpreter: No such file or directory", run dos2unix on the affected file:
   ```bash
   dos2unix <filename>
   ```
