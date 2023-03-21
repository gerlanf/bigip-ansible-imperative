## Prerequisites

- Install pipenv
  ```console
  $ python3.10 -m pip install pipenv -U --user
  ```

## How to Use

- Clone this repository

  - `git clone <repo URL>`

- Create a Python Virtual Environment Using pipenv

  ```console
  $ cd Projects/Ansible/ansible-f5-imperitive/
  $ python3.10 -m pipenv install
  ```

- Activate Python Virtual Environment

  ```console
  $ pipenv shell
  ```

- Install Ansible Collections

  ```console
  ansible-galaxy collection install -r collections/requirements.yaml --force
  ```

- Run the Playbook
  ```console
  $ ansible-playbook [playbook_name.yaml] -i inventories/[inventory_folder]/[inventory_file] --ask-vault-pass
  ```

  ## Example

- Run the Upgrade Playbook on 1 Host in the Lab

  ```console
  $ ansible-playbook playbooks/sys/upgrade_bigip_image_installed.yaml -i inventories/standby.yml --ask-vault-pass
  ```

- Run the Upgrade Playbook on the other Host in the Lab
  ```console
  $ ansible-playbook playbooks/sys/upgrade_bigip_image_installed.yaml -i inventories/standby.yml --ask-vault-pass
  ```
# ansible-f5-imperitive
