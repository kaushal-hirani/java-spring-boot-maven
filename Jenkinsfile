pipeline {
environment {
registry = "kaushalhirani/new-test"
registryCredential = 'docker_token'
dockerImage = ''
}
agent any
stages {
stage('Cloning our Git') {
steps {
git([url: 'https://github.com/kaushal-hirani/java-spring-boot-maven.git', branch: 'main', credentialsId: 'github_token'])
}
}
stage('Building our image') {
steps{
script {
dockerImage = docker.build registry 
}
}
}
stage('Deploy our image') {
steps{
script {
docker.withRegistry( '', registryCredential ) {
dockerImage.push("$BUILD_NUMBER")
dockerImage.push("latest")
}
}
}
}
stage('Run container on AWS Final'){
steps{
script{
def remote = [:]
remote.name = 'app server'
remote.host = '54.237.196.155'
remote.user = 'ec2-user'
remote.identityFile = "/var/lib/jenkins/.ssh/id_rsa.pem"
remote.allowAnyHosts = true
sshPut remote: remote, from: './docker-compose.yml', into: '.'
sshCommand remote: remote, command: "docker-compose top"
sshCommand remote: remote, command: "docker-compose down"
sshCommand remote: remote, command: "docker rmi -f kaushalhirani/new-test:latest"
sshCommand remote: remote, command: "docker-compose up -d"
sshCommand remote: remote, command: "docker ps"
}
}
}
stage('Cleaning up') {
steps{
sh "docker rmi $registry:latest"
sh "docker rmi $registry:$BUILD_NUMBER"
}
}
}
}