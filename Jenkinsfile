
pipeline {
    environment {
        registry = "sandeep4642/demo-app" 
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    agent none
    stages { 
        stage ('Build') {
            agent any
            steps {
                sh 'npm install'
                sh 'npm run build' 
                stash includes: '*', name: 'app'
            }
        }

        stage ('Build Docker image') {
            agent {label "slave"}
            steps {
                unstash 'app'
                script { 
                dockerImage = docker.build registry + ":$BUILD_NUMBER" 
            } 
            }
        }
        stage('Deploy our image into Registry') 
            agent {label "slave"} 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                    dockerImage.push() 
                    }
                } 
            }
        }
    }
