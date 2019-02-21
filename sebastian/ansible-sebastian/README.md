# Ansible playbook

## 1. Requirements

## 2. Installing ansible

1.  Install ansible by running `pip install ansible` or `sudo apt install ansible`

2.  Install the required roles:

        ansible-galaxy install geerlingguy.postgresql geerlingguy.java mcapitani.easy_service

## 3. Run the playbook

**NOTE:** Before following these instruction, you _must_ have ansible and the required roles installed on your working machine.
See section 2 for instructions.

1.  Create a file called (e.g.) `target.ini` with contents:

        [target]
        <target-ssh> dist_type=debian [ansible_python_interpreter=/usr/bin/python3]

    where `<target-ssh>` is a string allowing you do connect to the target system via ssh.
    Examples: `localhost`, `ubuntu@10.10.10.1` or an identifier specified in your `~/.ssh/config` file.
    You can also specify multiple targets for installation.

2.  Edit the contents of the `vars.yml` file with values appropriate to the desired installation.

3.  Run the playbook:

        ansible-playbook -i target.ini -e '@vars.yml' install-slicer.yml
