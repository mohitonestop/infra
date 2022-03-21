pipeline{
    agent any 
    
    environment {
        terraform="C:\\terraform\\terraform.exe"
        TF_IN_AUTOMATION = "true"
        PATH = "$terraform:$PATH"
    }
    stages {
            stage('Terraform Init'){
            
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure-service-principal',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'Azure-SA-tf', variable: 'ARM_ACCESS_KEY')]) {
                        
                        bat """
                                
                        echo "Initialising Terraform"
                        C:\\terraform\\terraform.exe init -backend-config="access_key=%ARM_ACCESS_KEY%"
                        """
                           }
                    }
             }
        }

        stage('Terraform Validate'){
            
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure-service-principal',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'Azure-SA-tf', variable: 'ARM_ACCESS_KEY')]) {
                        
                        bat """
                        C:\\terraform\\terraform.exe validate 
                        """
                           }
                    }
             }
        }
  
        stage('Terraform Plan'){
            steps {

                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure-service-principal',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'Azure-SA-tf', variable: 'ARM_ACCESS_KEY')]) {
                        
                        bat """
                        
                        echo "Creating Terraform Plan"
                        C:\\terraform\\terraform.exe plan -var "client_id=%ARM_CLIENT_ID%" -var "client_secret=%ARM_CLIENT_SECRET%" -var "subscription_id=%ARM_SUBSCRIPTION_ID%" -var "tenant_id=%ARM_TENANT_ID%"
                        """
                        }
                }
            }
        }

        stage('Waiting for Approval'){
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input (message: "Deploy the infrastructure?")
                }
            }
        
        }
    

        stage('Terraform Apply'){
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure-service-principal',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'Azure-SA-tf', variable: 'ARM_ACCESS_KEY')]) {

                        bat """
                        echo "Applying the plan"
                        C:\\terraform\\terraform.exe apply -auto-approve -var "client_id=%ARM_CLIENT_ID%" -var "client_secret=%ARM_CLIENT_SECRET%" -var "subscription_id=%ARM_SUBSCRIPTION_ID%" -var "tenant_id=%ARM_TENANT_ID%"
                        """
                                }
                }
            }
        }

        stage('Waiting for Remove Approval'){
            steps {
                timeout(time: 15, unit: 'MINUTES') {
                    input (message: "Clean the deployed infrastructure?")
                }
            }
        
        }
    

        stage('Terraform destroy'){
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure-service-principal',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'Azure-SA-tf', variable: 'ARM_ACCESS_KEY')]) {

                        bat """
                        echo "Applying the destroy"
                        C:\\terraform\\terraform.exe destroy -auto-approve -var "client_id=%ARM_CLIENT_ID%" -var "client_secret=%ARM_CLIENT_SECRET%" -var "subscription_id=%ARM_SUBSCRIPTION_ID%" -var "tenant_id=%ARM_TENANT_ID%"
                        """
                                }
                }
            }
        }
        
    }
}
