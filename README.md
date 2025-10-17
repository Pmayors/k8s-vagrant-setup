💻 Phase 1: Set Up Your Host Laptop
This is the software you need to install on your new Windows laptop.

Virtualization (Hypervisor):

Requirement: VirtualBox

Why: This is the software that actually runs your virtual machines (master and workers).

VM Automation:

Requirement: Vagrant

Why: This tool reads your Vagrantfile to automatically create, configure, and manage your VirtualBox VMs.

Terminal & Git:

Requirement: Git for Windows

Why: This gives you two things:

The git command for pushing to GitHub.

The MINGW64 / Git Bash terminal, which is the best way to run vagrant and ssh commands on Windows.

Code Editor:

Requirement: VS Code (or any text editor like Notepad++)

Why: You need this to write and save your Vagrantfile and provision.sh files without errors (like accidentally adding .txt to the end).
