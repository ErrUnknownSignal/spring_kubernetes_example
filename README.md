# spring boot kubernetes example


# requirements
- awscli2 https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- kubectl https://kubernetes.io/docs/tasks/tools/
- eksctl  https://eksctl.io/


# install cluster
```bash
eksctl create cluster -f cluster.yaml
```


# install aws loadbalancer controller
```bash
helm repo add eks https://aws.github.io/eks-charts
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam-policy.json
eksctl create iamserviceaccount \
--cluster=example-cluster \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::771193311267:policy/AWSLoadBalancerControllerIAMPolicy \
--approve
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
-n kube-system \
--set clusterName=example-cluster \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller

kubectl label namespace <YOUR-NAMESPACE> elbv2.k8s.aws/pod-readiness-gate-inject=enabled
```


# install argocd
```bash
#METRIC
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

#ARGOCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
# get default password
# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

#ARGO ROLLOUT
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
kubectl apply -k https://github.com/argoproj/argo-rollouts/manifests/crds\?ref\=stable
```