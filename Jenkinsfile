pipline{
    agent any
    environment {
        DOCKER_IMAGE = "ahmedihab/goviolin"
        DOCKER_TAG = "latest"
        }
    stages {
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