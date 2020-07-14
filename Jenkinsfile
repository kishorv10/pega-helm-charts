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
    sh "ls -l"
    withCredentials([usernamePassword(credentialsId: 'artifactory', passwordVariable: 'ARTIFACTORY_PASSWORD', usernameVariable: 'ARTIFACTORY_USER')]){

    }
    sh "cd ./charts/pega/"
    sh "ls -l"
    sh "helm dep update"
    sh "helm package --version 1.0 ./charts/pega/"
    sh "ls -l"
     sh "helm --help"
          //  ls -l ${packageName}.tgz
          //  MD5SUM=\$(md5sum ${PROJ}-${PackageVersion}.tgz | awk '{print \$1}')
          //  SHA1SUM=\$(sha1sum ${PROJ}-${PackageVersion}.tgz | awk '{print \$1}')
          //  SHA256SUM=\$(sha256sum ${PROJ}-${PackageVersion}.tgz | awk '{print \$1}')
          //    curl -XPUT --user ${env.USERNAME}:${env.PASSWORD} \
          //      --upload-file ${PROJ}-${PackageVersion}.tgz \
          //      -H"X-Checksum-Sha256:\${SHA256SUM}" \
          //      -H"X-Checksum-Sha1:\${SHA1SUM}" \
          //      -H"X-Checksum-Md5:\${MD5SUM}" \
          //      https://${ArtifactoryHostname}/helm/${PROJ}-${PackageVersion}.tgz
          //    # Re-index helm repo
          //    curl -v -XPOST --user ${env.USERNAME}:${env.PASSWORD} \
          //      https://${ArtifactoryHostname}/api/helm/helm-local/reindex
  }

 stage("Trigger Orchestrator") {
  jobMap = [:]
  jobMap["job"] = "../kubernetes-test-orchestrator/master"
  build jobMap
  echo "Changes with Orchestrator and Executor new"
  echo "New line"
 } 
}
