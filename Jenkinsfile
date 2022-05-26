pipeline{
    agent any
    environment {
        DOCKER_IMAGE = "ahmedihab/goviolin"
        DOCKER_TAG = "latest"
        root = tool type: 'go', name: 'Go-v1.18.2' 
        
        }
            tools {
        go 'Go-v1.18.2'
    }
    stages {
        stage ('Run Go tests') {
            steps{
                echo "Running go tests"
               sh 'go mod init '
                sh 'go mod tidy'
                sh 'go mod vendor'
                sh 'go test  ./...'
                }
        post {
            success {
                echo "Tests passed"
            }
            failure {
                echo "Tests failed"
            }

        }
        }

        stage ('Build Dockerfile'){
            steps{
            sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        post {
            success {
                echo "Docker image built successfully"
            }
            failure {
                echo "Docker image build failed"
            }

        }
        }

        stage ('Push Docker image'){
            steps{
             withCredentials([usernamePassword(credentialsId: 'Dockersecret', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])
                {
                sh """
                    docker login -u ${USERNAME} -p ${PASSWORD}
                    docker push $DOCKER_IMAGE:$DOCKER_TAG
                    """ 
                }
            }
        post {
            success {
                echo "Docker image pushed successfully"
            }
            failure {
                echo "Failed to push the image"
            }

        }
        }


    }
}