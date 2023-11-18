pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage("Compile") {
            steps {
                sh "./gradlew compileJava"
            }
        }
        stage("Unit test") {
            steps {
                sh "./gradlew test"
            }
        }
        stage("Code coverage") {
            steps {
                sh "./gradlew jacocoTestReport"
                publishHTML (target: [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: "JaCoCo Report"
                ])
                sh "./gradlew jacocoTestCoverageVerification"
            }
        }
        stage("Static code analysis") {
            steps {
                sh "./gradlew checkstyleMain"
                publishHTML (target: [
                    reportDir: 'build/reports/checkstyle',
                    reportFiles: 'main.html',
                    reportName: "Checkstyle Report"
                ])
            }
        }
        stage("Package") {
            steps {
                sh "./gradlew build"
            }
        }
        stage("Docker build and push") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    sh "docker login -u $USER -p $PASSWORD"
                    sh "docker build $USER/calculator-cicd:latest"
                    sh "docker push $USER/calculator-cicd:latest"
                    sh "docker rmi $USER/calculator-cicd:latest"
                }
            }
        }
    }
}