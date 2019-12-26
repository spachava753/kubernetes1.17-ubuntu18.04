IMAGE_NAME = "ubuntu/bionic64"

N = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    config.vm.provision "shell", path: "./bootstrap.sh"
    config.vm.synced_folder "./data", "/synced_folder"

    config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 2
    end
      
    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"
    	master.vm.provider "virtualbox" do |v|
	        v.memory = 4096
	        v.cpus = 2
	end
	master.vm.provision "shell", path: "bootstrap-master.sh"
	master.trigger.after :up do |trigger|
		trigger.run = {path: "./post.sh"}
	end
	master.trigger.before :up do |trigger|
		trigger.run = {inline: "./cleanup.sh"}
	end
    end

    (1..N).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            node.vm.hostname = "node-#{i}"
	    node.vm.provider "virtualbox" do |v|
        	v.memory = 2096
        	v.cpus = 1
    	    end
	    node.vm.provision "shell", path: "bootstrap-node.sh"
        end
    end

end
