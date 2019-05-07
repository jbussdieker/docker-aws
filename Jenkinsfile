#!groovy
properties([
  parameters([
    string(defaultValue: '1.16.154', description: 'Aws Version', name: 'AwsVersion')
  ])
])

node {
  awsVersion = params.AwsVersion
  credentialsId = 'docker-hub-credentials'

  stage('clone') {
    checkout scm
  }

  stage('build') {
    image = docker.build("jbussdieker/aws:${awsVersion}", "--build-arg aws_version=${awsVersion} .")
  }

  stage('test') {
    image.inside {
      sh "aws --version | grep ${awsVersion}"
    }
  }

  stage('publish') {
    docker.withRegistry("", credentialsId) {
      image.push()
    }
  }
}
