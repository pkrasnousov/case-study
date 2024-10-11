# Hello YAROWA web page repo

This repo contains:
1. `/app/` - simple Phyton app web page
2. `/helmchart/yarowa/` - HELM chart
3. `/helmfile.d/` - helmfile instructions
4. `dockerfile` - build docker image from `/app/`
5. THIS README.md


## Description
Following this instruction you should be able to run simple Python based application locally.
Inside k8s based on `k3s`

## Prerequisites
Solution tested on Ubuntu 24/04
Should be already installed next packages:
1. curl
2. git
3. kubectl
4. helm
5. helm diff plugin
6. helmfile

### Modify hosts file

```Bash
sudo vim /etc/hosts
```

Add string to `hosts` file
```Bash
127.0.0.1 casestudy.local.yarowa.io
```

It's assumed that you already have installed k3s with nginx-controller using host network.<br/>
If not - run next commands:
```Bash
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --disable traefik
mkdir ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
```
Check that `ingress-nginx-controller` deployed
```Bash
kubectl get pods --all-namespaces -w
NAMESPACE       NAME                                        READY   STATUS      RESTARTS   AGE
...
ingress-nginx   ingress-nginx-controller-65b9658c5f-xcmrs   0/1     Running     0          3h18m
...
```
Patch `ingress-nginx-controller` to use host network
```Bash
cat > ingress.yaml <<EOF
spec:
  template:
    spec:
      hostNetwork: true
EOF
kubectl patch deployment ingress-nginx-controller -n ingress-nginx --patch "$(cat ingress.yaml)"
```

## Deploy solution
!!! NOTICE !!!<br/>
Defult image `yarowa:0.1` was pre-built by `dockerfile` from this repo<br/>
And pushed to personal Dockerhub `pavelkleverx/yarowa`<br/>
<br/><br/>

Checkout repo
```Bash
git clone https://github.com/pkrasnousov/case-study.git
```

cd
```Bash
cd case-study
```
deploy app

```Bash
helmfile apply
```
After deployment completed run:
```Bash
curl casestudy.local.yarowa.io
```
and get
```Bash
Hello Yarowa AG!
```
## ChatGPT usage
ChatGPT was used to generate `.gitignore` files.