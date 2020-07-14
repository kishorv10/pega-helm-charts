#!/usr/bin/env groovy
def cloudDockerRegistryCredentialsId = '24cb9b3a-f0c3-4e12-b5dc-bfeead404fba'

node {
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
    def latest = "$latest"
    sh 'curl -fsSL -o jfrog https://api.bintray.com/content/jfrog/jfrog-cli-go/$latest/jfrog-cli-linux-386/jfrog?bt_package=jfrog-cli-linux-386'
    sh "ls -l"
    withCredentials([usernamePassword(credentialsId: 'artifactory', passwordVariable: 'ARTIFACTORY_PASSWORD', usernameVariable: 'ARTIFACTORY_USER')]){
      sh "jfrog --help"
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
