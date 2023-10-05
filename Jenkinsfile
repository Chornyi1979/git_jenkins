pipeline {
    agent any
    stages {
        stage('Clone repository') {
            steps {
                git branch: 'feature', url: 'https://github.com/Chornyi1979/git_jenkins.git'
            }
        }
        stage('Lint Dockerfiles') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image('hadolint/hadolint:2.12.1').inside {
                            sh 'hadolint Dockerfile'
                        }
                    }
                }
            }
        }
    }
}
