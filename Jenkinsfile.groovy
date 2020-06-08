#!/usr/bin/env groovy

def branchName                       = ''
def version                          = ''

node('pc-2xlarge') {
    def commonParameters = ''
    try {
        timestamps {
            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']) {
                wrap([$class: 'BuildUser']) {
                    /*withCredentials([usernamePassword(credentialsId: artifactoryCredentialsId,
                            passwordVariable: 'ARTIFACTORY_PASSWORD',
                            usernameVariable: 'ARTIFACTORY_USER')
                    ]) {*/
                        stage("Checkout") {
                            def scmVars = checkout scm
                            branchName = "${scmVars.GIT_BRANCH}"
                            currentBuild.displayName = "${branchName}-${env.BUILD_NUMBER}"
                            echo "SCM Checkout done"
                            sh "ls -l"
                        }
                        
                    //}
                }
            }
        }
    } catch(err) {
        echo "[FAILURE]: " + err.getMessage()
        if(currentBuild.result != 'UNSTABLE' && currentBuild.result != 'ABORTED') {
            currentBuild.result = 'FAILURE'
        }
       
    }
}
