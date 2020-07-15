#!/usr/bin/env groovy
def awsCredentialsId_PE = "CloudENG-Development"

node("pc-2xlarge") {
 stage ("Checkout and Package Charts") {
    sh "curl -fsSL -o helm-v3.2.4-linux-amd64.tar.gz https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz"
    sh "tar -zxvf helm-v3.2.4-linux-amd64.tar.gz"
    sh "mv linux-amd64/helm /usr/local/bin/helm"
    def scmVars = checkout scm
    branchName = "${scmVars.GIT_BRANCH}"
    currentBuild.displayName = "${branchName}-${env.BUILD_NUMBER}"
    packageName = currentBuild.displayName
    sh "helm dependency update ./charts/pega/"
    sh "helm package --version 1.0 ./charts/pega/"
    
    
     withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
								credentialsId: awsCredentialsId_PE,
								accessKeyVariable: 'AWS_ACCESS_KEY_ID_PE',
								secretKeyVariable: 'AWS_SECRET_ACCESS_KEY_PE']
                        ]) {
                    sh "aws s3 ls"
                    sh "aws s3 cp pega-1.0.tgz s3://kubernetes-pipeline/helm/ "


    }
    //sh 'curl -fsSL -o jfrog https://getcli.jfrog.io | sh'
    //sh "git clone https://github.com/jfrog/jfrog-cli"
    //def url = "https://api.bintray.com/content/jfrog/jfrog-cli-go/"+"$"+"latest"+"jfrog-cli-linux-386/jfrog?bt_package=jfrog-cli-linux-386"
    //sh "curl -fsSL -o jfrog https://api.bintray.com/content/jfrog/jfrog-cli-go/1.38.0/jfrog-cli-linux-386/jfrog?bt_package=jfrog-cli-linux-386"
    //sh "chmod 777 jfrog"
    //sh "ls -l"
   // withCredentials([usernamePassword(credentialsId: "bin.pega.io",
    //passwordVariable: 'ARTIFACTORY_PASSWORD', usernameVariable: 'ARTIFACTORY_USER')]) {
      //sh "./jfrog --help"
      //sh "./jfrog rt u pega-1.0.tgz  github-helm/ --url=https://meshbincam.pega.com/artifactory/ --user=${ARTIFACTORY_USER} --password=${ARTIFACTORY_PASSWORD}"
  //}
  }

 stage("Trigger Orchestrator") {
  jobMap = [:]
  jobMap["job"] = "../kubernetes-test-orchestrator/master"
  build jobMap
  echo "Changes with Orchestrator and Executor new"
  echo "New line"
 } 
}
