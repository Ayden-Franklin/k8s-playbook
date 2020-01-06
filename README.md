# k8s-playbook
Ansible playbook scripts for kubernetes setup.

---

#### Prepare the servers
Make sure the selinus status is disabled and firewalld is stopped.

#### Download binary packages.

#### Create CA certificates


```
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -days 10000 -out ca.pem -subj "/CN=kubernetes/O=k8s"
openssl genrsa -out kubernetes.key 2048
openssl req -new -key kubernetes.key -out kubernetes.csr -subj "/CN=kubernetes/O=k8s" -config openssl-kubernetes.cnf
openssl x509 -req -in kubernetes.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out kubernetes.pem -days 10000 -extensions v3_req -extfile openssl-kubernetes.cnf
openssl genrsa -out etcd.key 2048
openssl req -new -key etcd.key -out etcd.csr -subj "/CN=etcd/O=etcd" -config openssl-etcd.cnf
openssl x509 -req -in etcd.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out etcd.pem -days 10000 -extensions v3_req -extfile openssl-etcd.cnf
openssl genrsa -out proxy.key 2048
openssl req -new -key proxy.key -out proxy.csr -subj "/CN=system:kube-proxy"
openssl x509 -req -in proxy.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out proxy.pem -days 10000
openssl genrsa -out admin.key 2048
openssl req -new -key admin.key -out admin.csr -subj "/CN=admin/O=system:masters/OU=System"
openssl x509 -req -in admin.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out admin.pem -days 10000
```


#### Begin to install
Install ansible in any server and configure the `/etc/ansible/hosts` for ansible.

Then, run `deploy_all.sh` to install the k8s cluster.

