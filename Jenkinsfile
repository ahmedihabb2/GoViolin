pipeline{
    agent any
    tools {
        go 'Go-v1.18.2'
    }
    environment {
        DOCKER_IMAGE = "ahmedihab/goviolin"
        DOCKER_TAG = "latest"
        GO114MODULE = 'on'
        CGO_ENABLED = 0 
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
        }
    stages {
        stage ('Run Go tests') {
            steps{
                echo "Running go tests"
                withEnv(["PATH+GO=${GOPATH}/bin"]) {
                    sh """
                        go version
                        go mod init 
                        go mod tidy
                        go mod vendor
                        go test  ./...
                    """     
                }
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