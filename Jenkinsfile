//Jenkinsfile that is launched https://gauntlet-2.cloudbees.com/rosie/job/playground/job/bea/job/spring-petclinic/job/cb-tech-test/
//by default the status of the PR is marked with default check in the PR but if you know the plugin
// Pipeline GitHub Notify Step Plugin, it can be installed
node('with-basic-tools-bea') {
    // First heath test is to be sure you are executing testing before merging the PR
    stage("Build and test") {
        checkout scm
        def statusCodeInstall = sh script:"mvn install", returnStatus:true
        githubNotify context: 'BUILD', description: 'Build maven project', status: statusCodeInstall ? 'FAILURE' : 'SUCCESS'
        def statusCodeTest = sh script:"mvn test", returnStatus:true
        githubNotify context: 'TEST', description: 'Build test project', status: statusCodeTest ? 'FAILURE' : 'SUCCESS'
    }
}