#!groovy
latest = "1.16.154"
stable = "1.16.154"

properties([
  parameters([
    string(defaultValue: '1.16.154', description: 'Version', name: 'Version')
  ])
])

node {
  awsVersion = params.Version
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
      if (awsVersion == latest)
        image.push('latest')
      if (awsVersion == stable)
        image.push('stable')
    }
  }
}
