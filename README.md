# infra

An Ansible playbook that sets up an Ubuntu-based home media server/NAS with reasonable security, auto-updates, e-mail notifications for S.M.A.R.T. and Snapraid errors and dynamic DNS. 

It assumes a fresh Ubuntu Server 20.04 install, access to a non-root user with sudo privileges and a public SSH key. This can be configured during the installation process.

The playbook is mostly being developed for personal use, so stuff is going to be constantly changing and breaking. Use at your own risk and don't expect any help in setting it up on your machine.

## Special thanks
* David Stephens for his [Ansible NAS](https://github.com/davestephens/ansible-nas) project. This is where I got the idea and "borrowed" a lot of concepts and implementations from.
* Jeff Geerling for his book, [Ansible for DevOps](https://www.ansiblefordevops.com/) and his [Ansible 101 series](https://www.youtube.com/watch?v=goclfp6a2IQ&list=PL2_OBreMn7FqZkvMYt6ATmgC0KAGGJNAN) on YouTube.
* Jonathan Hanson for his [SSH port juggling](https://gist.github.com/triplepoint/1ad6c6060c0f12112403d98180bcf0b4) implementation.
* Alex Kretzschmar and Chris Fisher from [Self Hosted Show](https://selfhosted.show/) for introducing me to the idea of Infrastracture as Code
* TylerAlterio for the [mergerfs](https://github.com/tyalt1/mediaserver/tree/master/roles/mergerfs) role
* Jake Howard and Alex Kretzschmar for the [snapraid](https://github.com/RealOrangeOne/ansible-role-snapraid/commits?author=IronicBadger) role

## Services included:
#### Media
* [Plex](https://hub.docker.com/r/linuxserver/plex) (A media server)
* [Jellyfin](https://hub.docker.com/r/linuxserver/jellyfin) (Yet another media server)

#### Misc
* [Watchtower](https://hub.docker.com/r/containrrr/watchtower) (An automated updater for Docker images)

#### Home Automation
* [Home Assistant](https://hub.docker.com/r/homeassistant/home-assistant) (A FOSS smart home hub)
* [Phoscon-GW](https://hub.docker.com/r/marthoc/deconz) (A Zigbee gateway)

## Other features:
* MergerFS with Snapraid
* Samba

## Usage
Install Ansible (macOS):
```
brew install ansible
```
Install Ansible (Linux):
```
sudo apt-get install ansible \
    libsecret-tools &&  \ #for storing/accesing credentials 
    python3 -m pip install --upgrade --user ansible

```

Clone the repository:
```
git clone https://github.com/fcolasuonno/infra
```

Create a host variable file and adjust the variables:
```
cd infra/
mkdir -p host_vars/$YOUR_HOSTNAME
vi host_vars/$YOUR_HOSTNAME/vars.yml
```

Create a Keychain item for your Ansible Vault password (on macOS):
```
security add-generic-password \
               -a $YOUR_USERNAME \
               -s ansible-vault-password \
               -w
```

Create a Keyring item for your Ansible Vault password (on Linux):
```
secret-tool store \
    --label='ansible-vault-password' \
    application ansible-vault-password
```

The `pass.sh` script will extract the Ansible Vault password from your Keychain automatically each time Ansible requests it.

Create an encrypted `secret.yml` file and adjust the variables:
```
ansible-vault create host_vars/$YOUR_HOSTNAME/secret.yml
ansible-vault edit host_vars/$YOUR_HOSTNAME/secret.yml
```

Add your custom inventory file to `hosts`:
```
cp hosts_example hosts
vi hosts
```

Install the dependencies:
```
ansible-galaxy install -r requirements.yml
```

Make sure snapraid works:
```
vi ~/.ansible/roles/ironicbadger.snapraid/tasks/install-debian.ym
    version: fe6d34b3359867d0ca9b8248cf1b0e9059ff2cc5 #for build snapraid | clone git repo
```

Finally, run the playbook:
```
ansible-playbook run.yml -l your-host-here -K
```
The "-K" parameter is only necessary for the first run, since the playbook configures passwordless sudo for the main login user

For consecutive runs, if you only want to update the Docker containers, you can run the playbook like this:
```
ansible-playbook run.yml --tags="port,containers"
```

List used host
```
grep ip_address * -r | grep macvlan_network | grep -o 'nthhost.*)' | egrep -o '[0-9]+' | sort -nu
```