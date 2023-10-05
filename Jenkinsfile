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
                sh 'docker run --rm -i hadolint/hadolint:v1.22.1 < /var/lib/jenkins/workspace/pipeline_lab_feature/Dockerfile'
            }
        }
    }
}
