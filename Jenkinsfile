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
    sh "helm package --version ${env.BUILD_NUMBER} ./charts/pega/"
     withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
								credentialsId: awsCredentialsId_PE,
								accessKeyVariable: 'AWS_ACCESS_KEY_ID',
								secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']
                        ]) {

                    sh "aws s3 cp pega-${env.BUILD_NUMBER}.tgz s3://kubernetes-pipeline/helm/ "


    }
  }

 stage("Trigger Orchestrator") {
  jobMap = [:]
  jobMap["job"] = "../kubernetes-test-orchestrator/master"
  build jobMap
  echo "Changes with Orchestrator and Executor new"
  echo "New line"
 } 
}
