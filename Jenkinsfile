//Jenkinsfile that is launched https://gauntlet-2.cloudbees.com/rosie/job/playground/job/bea/job/spring-petclinic/job/cb-tech-test/
//by default the status of the PR is marked with default check in the PR but if you know the plugin
// Pipeline GitHub Notify Step Plugin, it can be installed
node('with-basic-tools-bea') {
    // First heath test is to be sure you are executing testing before merging the PR
    stage("Build and test") {
        checkout scm
        def statusCodeInstall = sh script:"mvn clean install -DskipTests", returnStatus:true
        githubNotify context: 'BUILD', description: 'Build maven project', status: statusCodeInstall ? 'FAILURE' : 'SUCCESS'
        def statusCodeTest = sh script:"mvn test", returnStatus:true
        githubNotify context: 'TEST', description: 'Build test project', status: statusCodeTest ? 'FAILURE' : 'SUCCESS'
        //example of other things that can be done
        def statusJacoco = sh script:'mvn -V -B -e org.jacoco:jacoco-maven-plugin:0.7.9:prepare-agent install org.jacoco:jacoco-maven-plugin:0.7.9:report -Dconcurrency=1 -Dfindbugs.failOnError=false -Ptest-coverage', returnStatus:true
        githubNotify context: 'JACOCO', description: 'Run jacoco', status: statusJacoco ? 'FAILURE' : 'SUCCESS'
        sh "cp target/*.jar spring-petclinic.jar"
        archiveArtifacts "spring-petclinic.jar"
    }
    stage("Create docker images") {
        def branchName = env.BRANCH_NAME
        unarchive mapping: ['spring-petclinic.jar': 'spring-petclinic.jar']
        def statusDockerBuild = sh script: "docker build . -t ${dockerImageName}:${branchName}", returnStatus:true
        githubNotify context: 'BUILD DOCKER', description: 'Build docker image of a project', status: statusDockerBuild ? 'FAILURE' : 'SUCCESS'

    }
}