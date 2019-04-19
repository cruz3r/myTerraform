function set-envvar{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [validateset("AWS","Azure")]
        [string]$provider,
        [Parameter(Mandatory)]
        [pscredential]$Credential,
        [string]$KeyVault = "kv-cruz3r",
        [string]$subscriptionname = 'Visual Studio Premium with MSDN'
    )
    $ErrorActionPreference = "Stop"
    if ($provider -eq "AWS"){
        Write-Verbose "AWS"
        try{
        Write-Output "AWS Env Variables"
        Login-AzureRmAccount -Credential $Credential -ErrorAction Stop
        Get-AzureRmSubscription -SubscriptionName $subscriptionname| Set-AzureRmContext | Out-Null
        $env:AWS_ACCESS_KEY_ID = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "awsAccessKeyId" ).SecretValueText
        $env:AWS_SECRET_ACCESS_KEY = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "awsSecretAccessKey" ).SecretValueText
        $env:TF_VAR_ssh_pub_key = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "publickey" ).SecretValueText
        # Write-Verbose env:TF_VAR_ssh_pub_key
        }catch{
            $Error[0].Message
        }
    }elseif ($provider -eq "Azure"){
        Write-Verbose "Azure"
        try{
        Write-Output "Azure Env Variables"
        Login-AzureRmAccount -Credential $Credential -ErrorAction Stop
        Get-AzureRmSubscription -SubscriptionName $subscriptionname| Set-AzureRmContext | Out-Null
        $env:ARM_SUBSCRIPTION_ID = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "azuresecretid" ).SecretValueText
        # Write-Verbose env:ARM_SUBSCRIPTION_ID
        $env:ARM_SUBSCRIPTION_ID = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "azuresubscriptionid" ).SecretValueText
        $env:ARM_CLIENT_ID = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "azureclientid" ).SecretValueText
        $env:ARM_CLIENT_SECRET = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "azureclientsecret" ).SecretValueText
        $env:ARM_TENANT_ID = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "azuretenantid" ).SecretValueText
        $env:ARM_ACCESS_KEY = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "azurestateaccesskey" ).SecretValueText
        $env:TF_VAR_ssh_pub_key = (Get-AzureKeyVaultSecret  -vaultName $KeyVault -Name "publickey" ).SecretValueText
        }catch{
            $Error[0].Message
        }
    }
}

function remove-envvar {
    param()
    Write-Output "Removing Azure and AWS Variables"
    Remove-Item env:\AWS_ACCESS_KEY_ID -ea SilentlyContinue
    Remove-Item env:\AWS_SECRET_ACCESS_KEY -ea SilentlyContinue
    Remove-Item env:\ARM_SUBSCRIPTION_ID -ea SilentlyContinue
    Remove-Item env:\ARM_CLIENT_ID -ea SilentlyContinue
    Remove-Item env:\ARM_CLIENT_SECRET -ea SilentlyContinue
    Remove-Item env:\ARM_TENANT_ID -ea SilentlyContinue
    Remove-Item env:\ARM_ACCESS_KEY -ea SilentlyContinue
    Remove-Item Env:\TF_VAR_ssh_pub_key -ea SilentlyContinue
}