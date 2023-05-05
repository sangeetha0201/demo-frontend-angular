
pipeline {
    environment {
        registry = "sandeep4642/demo-frontend-angular" 
        registryCredential = 'dockerhub'
        dockerImage = ''
        appname = "demo-frontend-angular"
    }
    agent { label "docker-slave"} 
    stages { 
        stage ('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build' 
            }
        }

        stage ('Build Docker image') { 
            steps {
                script { 
                dockerImage = docker.build registry + ":$BUILD_NUMBER" 
            } 
            }
        }
        stage ('Deploy our image into Registry'){
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                    dockerImage.push() 
                    }
                } 
            }
          }
          stage('Remove Unused docker image') {
            steps{
              sh "docker rmi $registry:$BUILD_NUMBER"
            }
          }
          stage('Deploy to Server'){ 
            steps{
                sh 'whoami'
                sh 'ansible-playbook /home/jenkins/demo-backend-deploy.yml --extra-vars "deploy_server=dev" --extra-vars "job_name=$registry"  --extra-vars "container_name=$appname" --extra-vars "build_no=$BUILD_NUMBER" --extra-vars "port_no=8080"'
                
            }
        }
        }
    }
