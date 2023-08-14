<!-- Logos -->
![Space Cat](/.attachments/space-cat.gif)

<!-- Intro -->
# Introduction
Repository for jamf aws elastic kubernetes service project. Infrastructure terraform configuration files present.

# CI/CD
The pipeline configuration runs a test pipeline that only triggers with branches that are not equal to main and a development branch that triggers when a merge occurs.

# Badges
* [![Test and deploy infrastructure](https://github.com/Ken501/jamf-assignment/actions/workflows/infrastructure.yml/badge.svg)](https://github.com/Ken501/jamf-assignment/actions/workflows/infrastructure.yml)
* [![Test and deploy VPC](https://github.com/Ken501/jamf-assignment/actions/workflows/network.yaml/badge.svg)](https://github.com/Ken501/jamf-assignment/actions/workflows/network.yaml)
* [![Test and deploy external dns controller](https://github.com/Ken501/jamf-assignment/actions/workflows/extdns.yml/badge.svg)](https://github.com/Ken501/jamf-assignment/actions/workflows/extdns.yml)
* [![Test and deploy AWS Ingress controller](https://github.com/Ken501/jamf-assignment/actions/workflows/ingress-controller.yml/badge.svg)](https://github.com/Ken501/jamf-assignment/actions/workflows/ingress-controller.yml)
* [![Test and deploy wordpress](https://github.com/Ken501/jamf-assignment/actions/workflows/wordpress.yml/badge.svg)](https://github.com/Ken501/jamf-assignment/actions/workflows/wordpress.yml)

<!-- Dir Summary -->
# Directory Guide
* .attachments
  * Stores images and references for readme
* .github
    * Stores CI/CD pipeline configuration files in yaml format
* helm
    * Stores Helm Charts deployments in Terraform configuration
* Infrastructure
    * Stores Terraform configuration files
* modules
    * Stores Terraform modules
* network
    * Stores custom AWS VPC

<details>
<summary><b>Expand to see..</b></summary>
* Wordpress Deployment
![wordpress Deployment](/.attachments/wordpress.kmartinez.net.PNG)

</details>

# Before Proceeding make sure to install the following:
* Install **latest** version of AWS eksctl
  * Instructions: https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html
* Install **latest** version of kubectl
  * Instructions: https://kubernetes.io/docs/tasks/tools/
* Install **latest** version of AWS CLI V2
  * Instructions: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
* To connect to cluster after installing above binaries jump to **KubeConfig** instructions further below.
  * For more info on kubeconfig visit: https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/
  * EKS KubeConfig documentation: https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html
  * **NOTE**: for the above to work a **local AWS cli profile is needed.** For more info on how to configure local aws profile see **Additional documentation** further below for instructions.

# Naming convention
* AWS kubernetes associated resources will be named: **<env>-<app_name>-<aws-resource>-<region>**
  * Example: **test-k8s-cluster-use1**

# AWS IAM and Cluster Auth Instructions:
* Since the cluster is being created in CI/CD by the Deployment IAM user keys that reside in nonprod and prod accounts respectively the cluster configmap, **aws-auth**, that runs as a **configmap cluster object** needs to be updated with **eksctl** to allow the IAM roles used via myapps for nonprod and prod to access and interact with the cluster. If this is not done you will **NOT** be able to authenticate and control the cluster with **eksctl** **NOR** view cluster objects with IAM role within AWS Console.
* For more information on the above refer to the following documentation:
  * https://docs.aws.amazon.com/eks/latest/userguide/view-kubernetes-resources.html#view-kubernetes-resources-permissions
  * https://kubernetes.io/docs/reference/access-authn-authz/rbac/
# Example commands to enable/authenticate IAM Role with eksctl to interact with cluster and view resources on AWS Console:
```
eksctl create iamidentitymapping \
--cluster dev-wp-cluster-use1 \
--region us-east-1 \
--profile kmadmin \
--arn arn:aws:iam::449321421705:user/kmadmin \
--group system:masters \
--username devops-admins
```
* Within "**--profile kmadmin**" this refers to locally configured aws cli profile to interact with correct AWS account. This name is subject to change depending on your local aws cli config profile.
## To retrieve identity mappings:
```
eksctl get iamidentitymapping \
--cluster dev-wp-cluster-use1 \
--region us-east-1 \
--profile kmadmin
```

<!-- kubeconfig commands -->
# KubeConfig
* To interact with a cluster configure the local kubeconfig by running the following command:
```
aws eks update-kubeconfig --region <region> --name <cluster-name> --profile <local aws profile>
```
* The above command will update the kubeconfig within ~$HOME/.kube

# Example:
```
aws eks update-kubeconfig \
--region=us-east-1 \
--name=dev-wp-cluster-use1 \
--profile=kmadmin
```

# kubectl autocomplete
```
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
```
# kubectl shorthand
```
alias k=kubectl
complete -o default -F __start_kubectl k
```

# Additional documentation

* To learn how to configure local aws profiles visit: 
   *  https://awscli.amazonaws.com/v2/documentation/api/latest/reference/configure/index.html
* For a full list of AWS ALB annotations visit: 
   * https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/ingress/annotations/#annotations
* Kubernetes API Documentation:
    * https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/
* Official AWS Ingress Conroller GitHub and documentation: 
   * https://github.com/kubernetes-sigs/aws-load-balancer-controller
   * How ingress controller works: https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/how-it-works/
* Kubernetes external DNS:
    * https://github.com/kubernetes-sigs/external-dns
* For all documentation regarding helm:
  * https://helm.sh/
  * https://bitnami.com/stacks/helm
  * https://github.com/bitnami/charts
  * https://helm.sh/docs/intro/install/

# Cheat Sheet
* Describe cluster resource
```
kubectl describe <api-resource>
```
* Get cluster resource
```
kubectl get <api-resource> -o wide
or
kubectl get <api-resource> -o yaml
```
* Create and delete pods
```
kubectl run nginx --image=nginx

kubectl delete pod nginx
```
* Create and delete deployments
```
kubectl create deployment nginx-deploy --image=nginx --replicas=2

kubectl delete deployment nginx-deploy
```
* Expose a deployment or pod cluster object
```
kubectl expose <api-resource> --name=http-svc --port=80 --type=NodePort
```

<!-- Dir Tree Structure -->
# Directory Tree Structure

```
│   .gitignore
│   LICENSE
│   README.md
│   
├───.attachments
│       space-cat.gif
│
├───.github
│   └───workflows
│           extdns.yml
│           infrastructure.yml
│           ingress-controller.yml
│           network.yaml
│           output.yaml
│           wordpress.yml
│
├───helm
│   ├───external-dns-controller
│   │       backend.tf
│   │       data.tf
│   │       external-dns.tf
│   │       global-vars.tf
│   │       iam.tf
│   │       locals.tf
│   │       oidc.tf
│   │       provider.tf
│   │       variables.tf
│   │
│   ├───ingress-controller
│   │   │   backend.tf
│   │   │   data.tf
│   │   │   global-vars.tf
│   │   │   iam.tf
│   │   │   ingress-controller.tf
│   │   │   locals.tf
│   │   │   oidc.tf
│   │   │   provider.tf
│   │   │   variables.tf
│   │   │
│   │   └───policies
│   │           AWSLoadBalancerController.json
│   │
│   └───wordpress
│           backend.tf
│           data.tf
│           global-vars.tf
│           locals.tf
│           oidc.tf
│           provider.tf
│           variables.tf
│           wordpress.tf
│
├───infrastructure
│       backend.tf
│       cluster.tf
│       global-vars.tf
│       namespaces.tf
│       provider.tf
│       variables.tf
│
├───modules
│   ├───eks
│   │       addons.tf
│   │       cluster.tf
│   │       data.tf
│   │       iam.tf
│   │       locals.tf
│   │       oidc.tf
│   │       output.tf
│   │       sg.tf
│   │       variables.tf
│   │       versions.tf
│   │
│   └───global-vars
│           locals.tf
│           outputs.tf
│           readme.md
│           variables.tf
│
└───network
        backend.tf
        locals.tf
        provider.tf
        variables.tf
        versions.tf
        vpc.tf
```

# Terraform Resources
* EKS
* ALB
* R53 Records
* AWS VPC