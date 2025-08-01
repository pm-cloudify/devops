# Configuration Management

here is the project related to working with ansible.

### how to use

1- add inventory.ini or inventory.yaml <br>
2- use following commands to check everything is ok and then apply configs:

```bash
ansible-inventory -i inventory.ini --list
ansible test_servers -i inventory.ini -m ping
# ansible-playbook setup.yaml -i inventory.ini --tags ssh
ansible-playbook setup.yaml -i inventory.ini --skip-tags ssh
```
