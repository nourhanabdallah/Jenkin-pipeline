
pipeline {
    
    agent any
    
     environment {
         DOCKER_IMAGE_NAME = 'docker_image'
        DOCKER_TAR_PATH = "${DOCKER_IMAGE_NAME}.tar"
        ANSIBLE_PLAYBOOK = 'InstallApache.yml/apache-playbook.yml'
        VM3_HOST = 'InstallApache.yml/inventories'
         
         
        }
   
    stages{
        
        stage("cloning-script"){
            steps{
                
                script {
                    // Checkout the repository from Gogs using HTTP with credentials
                    withCredentials([usernamePassword(credentialsId: '39746a99-22a3-47b1-a055-031bcfa9bd91', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        git config --global credential.helper cache
                        git config --global credential.username ${GIT_USERNAME}
                        echo ${GIT_PASSWORD} | git clone http://${GIT_USERNAME}:${GIT_PASSWORD}@192.168.24.150:3000/nourhan/NotGroupMember.git
                         '''
                        }
                        
                    
                
                
                
                        }
            }
        }
        stage("executing script"){
        steps{
            script{
                	 

            def remote = [:]
                   remote.name = 'VM3'
                  remote.host = '192.168.24.148'
                  remote.user = 'NourhanAbdallah'
                  remote.password = '123'
                  remote.allowAnyHosts = true
       
             sshScript remote: remote, script: "NotGroupMember/NotGroupMembers.sh"
      

            }
        }
    }
    
    
    
    
    stage("cloning-DockerFile"){
        steps{
            script{
                
                 def remote = [:]
                  remote.name = 'VM3'
                  remote.host = '192.168.24.148'
                    remote.user = 'NourhanAbdallah'
                    remote.password = '123'
                     remote.allowAnyHosts = true
  
                
                	 withCredentials([usernamePassword(credentialsId: '39746a99-22a3-47b1-a055-031bcfa9bd91', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                                 sshCommand remote: remote, command:"echo ${GIT_PASSWORD} | git clone http://${GIT_USERNAME}:${GIT_PASSWORD}@192.168.24.150:3000/nourhan/BuildDockerImage.git"       

                                }
                          sshCommand remote: remote, command:  "docker build -t ${DOCKER_IMAGE_NAME} BuildDockerImage"
                          sshCommand remote: remote, command: "docker save ${DOCKER_IMAGE_NAME} > ${DOCKER_TAR_PATH}"
 
                
                
                
                
                
            }
            
            
            
            
            
        }
        
        
        
        
    }
    stage("Cloning-and-Running-Ansible"){
        steps{
            script{
                
                 def remote = [:]
                  remote.name = 'VM3'
                  remote.host = '192.168.24.148'
                    remote.user = 'NourhanAbdallah'
                    remote.password = '123'
                     remote.allowAnyHosts = true
                     
                       withCredentials([usernamePassword(credentialsId: '39746a99-22a3-47b1-a055-031bcfa9bd91', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        git config --global credential.helper cache
                        git config --global credential.username ${GIT_USERNAME}
                        echo ${GIT_PASSWORD} | git clone http://${GIT_USERNAME}:${GIT_PASSWORD}@192.168.24.150:3000/nourhan/InstallApache.yml.git
                         '''
                        }
                        ansiblePlaybook credentialsId: '87ee9069-f861-4040-8ac4-0f2aaba2e050', disableHostKeyChecking: true, installation: 'Ansible', playbook: 'InstallApache.yml/apache-playbook.yml'
                        
                        
           
                
				
                        
                      
                                
                                
                                
                                
                                
                                
                                
            }         
            
            
            
        }
        
        
        
    }
 
 
 
} 


post {
        always {
            echo 'Cleaning up workspace'
            cleanWs()
        }
    }



}
