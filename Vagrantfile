# Vagrantfile
Vagrant.configure("2") do |config|
  # Use Ubuntu 22.04 LTS (Jammy)
  config.vm.box = "ubuntu/jammy64"
  config.ssh.insert_key = false

  # Disable default synced folder
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Master Node Configuration
  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.56.11"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "4096" # 4GB RAM for master
      vb.cpus = "2"
    end
    # PROVISIONING DISABLED:
    master.vm.provision "shell", path: "provision.sh"
  end

  # Worker Nodes Configuration (Loop for 2 workers)
  (1..2).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.hostname = "worker#{i}"
      worker.vm.network "private_network", ip: "192.168.56.#{11 + i}" # .12, .13
      worker.vm.provider "virtualbox" do |vb|
        vb.memory = "2048" # 2GB RAM for workers
        vb.cpus = "2"
      end
      # PROVISIONING DISABLED:
       worker.vm.provision "shell", path: "provision.sh"
    end
  end
end
