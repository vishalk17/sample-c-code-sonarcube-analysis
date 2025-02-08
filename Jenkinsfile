// Send Email notification to the below addresses
def emailRecipients = 'vishalkapadi95@gmail.com'
// For multiple recipients: def emailRecipients = 'xyz@gmail.com,abc@gmail.com'

pipeline {
    agent {
        label 'master'  // Node label -> run job on node where node label is master
    }
    environment {
        BUILD_URL = "${env.BUILD_URL}"               // Build URL
        CONSOLE_URL = "${BUILD_URL}console"          // Console output URL
        BLUE_OCEAN_URL = "${JENKINS_URL}blue/organizations/jenkins/${JOB_NAME}/detail/${JOB_NAME}/${BUILD_NUMBER}/pipeline" // Blue Ocean URL
        JOB_NAME = "${env.JOB_NAME}"                 // Job Name
        BUILD_NUMBER = "${env.BUILD_NUMBER}"         // Build Number

        SONAR_SCANNER_HOME = tool 'sonar-scanner'
        BUILD_WRAPPER_HOME = "/usr/local/bin/build-wrapper-linux-x86-64"
        BRANCH_NAME = "master"                       // Branch for SonarQube analysis

        SONAR_PROJECT_KEY = "test-project"           // Project key
        SONAR_PROJECT_NAME = "test-project"          // Project name
        SONAR_ORGANIZATION = "vishalk17"
        SONAR_INCLUSIONS = "**/*.c,**/*.h"           // Scan only .c and .h files
        SONAR_BUILD_WRAPPER_OUTPUT = "bw-output"
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: "${BRANCH_NAME}", url: 'https://github.com/vishalk17/sample-c-code-sonarcube-analysis'
            }
        }
        stage('Compile with Build Wrapper') {
            steps {
                sh "${BUILD_WRAPPER_HOME} --out-dir ${SONAR_BUILD_WRAPPER_OUTPUT} make clean all"
            }
        }
        stage('SonarQube Scan') {
            steps {
                withSonarQubeEnv('sonar-server-paid') {  // Preconfigured SonarQube server
                    sh """
                        ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.projectName=${SONAR_PROJECT_NAME} \
                        -Dsonar.organization=${SONAR_ORGANIZATION} \
                        -Dsonar.sources=. \
                        -Dsonar.inclusions=${SONAR_INCLUSIONS} \
                        -Dsonar.language=c \
                        -Dsonar.cfamily.build-wrapper-output=${SONAR_BUILD_WRAPPER_OUTPUT} \
                        -Dsonar.branch.name=${BRANCH_NAME}
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'SonarQube analysis completed successfully.'
            script {
                currentBuild.result = 'SUCCESS'
                emailext(
                    subject: "SonarQube Analysis Success for: ${JOB_NAME} #${BUILD_NUMBER}",
                    mimeType: 'text/html',
                    body: """
                        The job has succeeded.<br>
                        <a href='${BUILD_URL}'>View the job in Jenkins</a><br>
                        <a href='${CONSOLE_URL}'>View console output</a><br>
                        <a href='${BLUE_OCEAN_URL}'>View in Blue Ocean</a>
                    """,
                    to: emailRecipients
                )
            }
        }
        failure {
            echo 'SonarQube analysis failed.'
            script {
                currentBuild.result = 'FAILURE'
                emailext(
                    subject: "SonarQube Analysis Failed for: ${JOB_NAME} #${BUILD_NUMBER}",
                    mimeType: 'text/html',
                    body: """
                        The job has failed.<br>
                        <a href='${BUILD_URL}'>View the job in Jenkins</a><br>
                        <a href='${CONSOLE_URL}'>View console output</a><br>
                        <a href='${BLUE_OCEAN_URL}'>View in Blue Ocean</a>
                    """,
                    to: emailRecipients
                )
            }
        }
    }
}
