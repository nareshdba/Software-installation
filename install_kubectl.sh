#Linux (amd64) URL : https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html#linux_amd64_kubectl
#Download the kubectl binary for your cluster’s Kubernetes version from Amazon S3.
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.32.0/2024-12-20/bin/linux/amd64/kubectl
#Apply execute permissions to the binary
chmod +x ./kubectl
#Copy the binary to a folder in your PATH. If you have already installed a version of kubectl, then we recommend 
#creating a $HOME/bin/kubectl and ensuring that $HOME/bin comes first in your $PATH.
#mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH(if required or else below command)
sudo mv kubectl /usr/local/bin
#Verify the below command to status of installation.
kubectl version --client
###output 
#######Client Version: v1.32.0-eks-5ca49cb
#######Kustomize Version: v5.5.0
