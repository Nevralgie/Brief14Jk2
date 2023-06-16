pipeline{
    agent any
    //Specify what tool you want to use
    //The tool name needs to match the one you used in your jenkins conf
    tools {
        terraform 'Terraform'
    }
     stages{
         //Check the version and download any changes 
        stage('Git Checkout'){
            steps{
               checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Nevralgie/Brief14Jk2']])
            }
        }
         //stage('Login'){
             //steps{
                 //azureCLI commands: [[exportVariablesString: '', script: '']], principalCredentialId: 'c9d080da-ebeb-4030-b06e-a90d691bfab7'
             //}
         //}
        stage('Build') {
            steps {


                // Run Maven on a Unix agent.
                // sh "mvn -Dmaven.test.failure.ignore=true clean package"
                sh "docker build -t apptestjkb14 ."

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

            
        }
        stage('Push') {
            steps {
                sh "docker login -u nevii --password dckr_pat_ZaOkL3fPhwN_iSvimZ8YAxjTwvk"
                sh "docker image tag apptestjkb14:latest nevii/apptestjkb14:latest"
                sh "docker image push nevii/apptestjkb14:latest"
            }
        }
        //Initiate the directory as the current workspace
        stage('Terraform init'){
            steps{ 
                //dir("ProdEnvironment") {
                
                //sh 'terraform init'
                //}
                dir("stagingEnvironment") {
                
                sh 'terraform init -upgrade'
                }
            }
        }
        //Plan your deployment
        stage('Terraform plan'){
            steps{
                //dir("ProdEnvironment") {
                //sh 'terraform plan -out main.tfplan'
                //}
                dir("stagingEnvironment") {
                
                sh 'terraform plan -out main.tfplan'
                }
            }
        }
        //Apply your deployment
        //Note that if the -auto-approve flag is not present, jenkins can not approve the apply and the build will fail.
        stage('Terraform apply'){
            steps{
                //dir("ProdEnvironment") {
                //sh 'terraform apply main.tfplan' //-auto-approve
                //}
                dir("stagingEnvironment") {
                
                sh 'terraform apply main.tfplan'
                }
            }
        }  
        stage('Sanity check') {
            steps {
                input "Does the staging environment look ok?"
            }
        }
        
        stage('Deploy - Production') {
            steps {
                dir("ProdEnvironment") {
                
                sh 'terraform init -upgrade'
                //sh 'terraform import "module.azure-webserver.azurerm_resource_group.webserver" "/subscriptions/393e3de3-0900-4b72-8f1b-fb3b1d6b97f1/resourceGroups/Brief14Jk"'
                sh 'terraform plan -out main.tfplan'
                sh 'terraform apply main.tfplan'
                }
            }
        }
    }
}
