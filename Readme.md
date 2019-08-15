# Terraform Practice

Working with Terraform examples.

# Destory
kubectl.exe delete -f ..\..\Kubernetes\test.yml


terraform.exe destroy

* azurerm_public_ip.pip: Error deleting Public IP "public_ip" (Resource Group "MC_azure-k8stest_k8stest_eastus"): network.PublicIPAddressesClient#Delete: Failure sending request: StatusCode=400 -- Original Error: Code="PublicIPAddressCannotBeDeleted" Message="Public IP address /subscriptions/0205039f-408e-4369-a11f-b45ab53ceb52/resourceGroups/MC_azure-k8stest_k8stest_eastus/providers/Microsoft.Network/publicIPAddresses/public_ip can not be deleted since it is still allocated to resource /subscriptions/0205039f-408e-4369-a11f-b45ab53ceb52/resourceGroups/MC_azure-k8stest_k8stest_eastus/providers/Microsoft.Network/loadBalancers/kubernetes/frontendIPConfigurations/ab46a61ff7d7711e99c1c4617d04b9e8. In order to delete the public IP, disassociate/detach the Public IP address from the resource.  To learn how to do this, see aka.ms/deletepublicip." Details=[]

Delete PIP Manually?
terraform.exe destroy