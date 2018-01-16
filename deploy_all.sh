#!/bin/bash
cd playbook
#for file in `ls -l *.yaml | grep ^- |  awk '{ print $9}'`; do
  #echo ${file};
#  ansible-playbook ${file};
#done

ansible-playbook prepare.yaml
ansible-playbook etcd.yaml
ansible-playbook flannel.yaml
ansible-playbook docker.yaml
ansible-playbook kubernetes.yaml
ansible-playbook finalize.yaml
