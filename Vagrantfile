# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

# get details of boxes to build
boxes = YAML.load_file('./boxes.yaml')

# API version
VAGRANTFILE_API_VERSION = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  boxes.each do |boxes|
    config.vm.define boxes['name'] do |srv|
      # OS and hostname
      srv.vm.box = boxes['box']
      if boxes['box_version']
        srv.vm.box_version = boxes['box_version']
      end
      srv.vm.hostname = boxes['name']

      # Networking.  By default a NAT interface is added.
      # Add an internal network like this:
      #   srv.vm.network 'private_network', type: 'dhcp', virtualbox__intnet: true
      # Add a bridged network
      if boxes['public_network']
        if boxes['public_network']['ip']
          srv.vm.network 'public_network', bridge: boxes['public_network']['bridge'], ip: boxes['public_network']['ip']
        else
          srv.vm.network 'public_network', bridge: boxes['public_network']['bridge']
        end
      end

      if boxes['ssh_port']
        srv.vm.network :forwarded_port, guest: 22, host: boxes['ssh_port'], host_ip: '127.0.0.1', id: 'ssh'
      end

      # Set auto_update to false if you do NOT want to check and install the correct additions version when booting this machine
      if boxes['vboxguest_update']
        srv.vbguest.auto_update = boxes['vboxguest_update']
      else
        srv.vbguest.auto_update = false
      end

      # Shared folders
      # Other options: create: "true", type: "virtualbox", disabled: true
      srv.vm.synced_folder '.', '/vagrant', disabled: true
      srv.vm.synced_folder './share/', '/home/vagrant/share'

      srv.vm.provider 'virtualbox' do |vb|
        vb.customize ['modifyvm', :id, '--cpus', boxes['cpus']]
        vb.customize ['modifyvm', :id, '--cpuexecutioncap', boxes['cpu_execution_cap']]
        vb.customize ['modifyvm', :id, '--memory', boxes['ram']]
        vb.customize ["modifyvm", :id, "--vram", boxes['video_ram']]
        vb.customize ['modifyvm', :id, '--name', boxes['name']]
        vb.customize ['modifyvm', :id, '--description', boxes['description']]
        vb.customize ['modifyvm', :id, '--groups', '/vagrant']
        vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']

        # enable remote display (RDP) for box
        if boxes['remote_display_port']
          vb.customize ['modifyvm', :id, '--vrde', 'on']
          vb.customize ['modifyvm', :id, '--vrdeaddress', '127.0.0.1']
          vb.customize ['modifyvm', :id, '--vrdeport', boxes['remote_display_port']]
        else
          vb.customize ['modifyvm', :id, '--vrde', 'off']
        end

        # Enable vbox gui (preference is to use remote display)
        if boxes['gui']
          vb.gui = boxes['gui']
        else
          vb.gui = false
        end
      end

      if boxes['provision']
        if boxes['provision']['cloud-init']
          begin
            srv.vm.provision :file, :source => boxes['provision']['cloud-init']['meta'], :destination => '/tmp/cloud-init/meta-data'
            srv.vm.provision :file, :source => boxes['provision']['cloud-init']['user'], :destination => '/tmp/cloud-init/user-data'
            srv.vm.provision :shell, :path => boxes['provision']['cloud-init']['script']
          rescue => e
            puts e.backtrace
            abort('There was an error in cloud-init provisioning.')
          end
        end

        if boxes['provision']['scripts']
          begin
            boxes['provision']['scripts'].each do |s|
              srv.vm.provision :shell, :path => s
            end
          rescue => e
            puts e.backtrace
            abort('There was an error in general script provisioning.')
          end
        end
      end

    end
  end
end
