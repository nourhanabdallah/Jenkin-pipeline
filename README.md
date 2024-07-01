# Jenkins Pipeline for
## Executing script
## Docker Image Build 
## Ansible Deployment

This Jenkins pipeline automates the process of cloning repositories,executing a scripton remote machine, building a Docker image, saving the Docker image as a tar file, and running an Ansible playbook for install httpd on remote machine.

# Stage OverView
![image](https://github.com/nourhanabdallah/Nourhan-Abdallah/assets/125203973/08bf7d16-5c79-497f-b41c-23a05a3630a4)



# Pipeline Overview

### The pipeline consists of the following stages:

## 1. Cloning Script Repository: Clones a repository containing NotGroupMember.sh from Gogs into pipeline workspace & using `withCredentials` to pass username and password 
## 2. Executing Script: Runs a script on VM3 : using plugin `ssh steps` and command `sshScript remote: remote, script:`   
                   `Stg-Result` :
![image](https://github.com/nourhanabdallah/Nourhan-Abdallah/assets/125203973/ead673d4-4121-4d28-ac91-2e9c6e2c2cb3)

## 3. Cloning DockerFile from Gogs , build it and tar on VM3 by ssh command : 
                     `sshCommand remote: remote, command: "docker build -t ${DOCKER_IMAGE_NAME} BuildDockerImage"`
                    `sshCommand remote: remote, command: "docker save ${DOCKER_IMAGE_NAME} > ${DOCKER_TAR_PATH}"`
  Note: all variable used are declared on `environment { }` as aglobal

                        stg-Result 
 ![image](https://github.com/nourhanabdallah/Nourhan-Abdallah/assets/125203973/00c01a2e-9a16-4bc6-b7ab-45b6b4223472)

 ![image](https://github.com/nourhanabdallah/Nourhan-Abdallah/assets/125203973/07d5a97e-eb76-4dc3-a111-f07a09e75113)




## 4. Run Ansible playbook "in this case jenkins server became (`ansible Master`)" 
 - clone playbook with roles and inventories"i used ansible default hosts file `/etc/ansible/hosts` "
 - install plugin ansible to run ansible commands , i used this command :
   `ansiblePlaybook credentialsId: '87ee9069-f861-4040-8ac4-0f2aaba2e050', disableHostKeyChecking: true, installation: 'Ansible', playbook: 'InstallApache.yml/apache-playbook.yml'`

                                                              Stg-Result
   ![image](https://github.com/nourhanabdallah/Nourhan-Abdallah/assets/125203973/8c259a85-db53-48c5-910e-872944f363db)

                                              on VM3
   ![image](https://github.com/nourhanabdallah/Nourhan-Abdallah/assets/125203973/9ccca90b-bed0-4971-b76f-a2b09b7282ea)



   ## 5. finally i clean workspace to avoid errors incase rebuild pipeline

   ![image](https://github.com/nourhanabdallah/Nourhan-Abdallah/assets/125203973/475f56ff-8edf-44f1-adac-a56ec1c647c2)




                          
                

                   
