# things to do

Look into imagepullsecrets
This is needed to pull the secrets so that K8s can pull from Azure Container Registry acr

az login
az account list -o table
az account set --subscription ""

az container list

# Create the Azure Container Registry
# az acr create --resource-group <RESOURCE-GROUP-NAME> --name <CONTAINER-REGISTRY-NAME> --sku Basic --admin-enabled true


# Login to Container Registyr
az acr login -n azk8sregistry -g azure-k8stest

az acr show --name azk8sregistry --query loginServer --output table

# build your docker image
docker build .
docker images
# Tag your docker image with the acr loginserver
docker tag packer_test azk8sregistry.azurecr.io/packer_test:v1

# Push the image to azure container registry
docker push azk8sregistry.azurecr.io/packer_test:v1

az acr repository list --name azk8sregistry --output table

az acr repository show-tags --name azk8sregistry --repository packer_test --output  table

# Create the Kubernetes Cluster (this was done with Terraform)

# Download kubectl
az aks install-cli
# Configure Kubectl to connect to your kubernetes cluster
# add cert to kube config
az aks Get-Credentials -g <RESOURCE-GROUP-NAME> -n<K8sName>
az aks Get-Credentials -g azure-k8stest -n k8stest
cat C:\Users\m.cruz\.kube\config

#browse to Kubernetes
az aks browse --resource-group azure-k8stest --name k8stest

# This was to create a public IP in the Node RG It is now in the Terraform file
az network public-ip create --resource-group MC_azure-k8stest_k8stest_eastus  --name myAKSPublicIP  --allocation-method static
az network public-ip list --resource-group MC_azure-k8stest_k8stest_eastus --query [0].ipAddress --output tsv

# Getting Kubectl to work with Azure

After re-provisioning the Azure Kubernetes Cluster you have to re run the section to add the credential information to your .kube/config
kubectl get nodes -- Shows that it is not connected
Rename-Item C:\Users\m.cruz\.kube\config C:\Users\m.cruz\.kube\config2  -- renames existing config
az aks Get-Credentials -g <RESOURCE-GROUP-NAME> -n<K8sName>  -- Generates a new config file with the certificate information
cat C:\Users\m.cruz\.kube\config  -- Shows the new Cert information
cat C:\myGit\terraform\Kubernetes\test.yml
terraform.exe output pip  -- This is the ip address needed for the test.yml loadBalancerIP
kubectl apply -f C:\myGit\terraform\Kubernetes\test.yml