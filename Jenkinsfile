node {
    ECR_HOST = '0000000000000.dkr.ecr.ap-northeast-2.amazonaws.com'
    ECR_SECRET = 'ecr_secret'


     stage('git checkout') {
        checkout scm
     }

     stage('gradle build') {
        sh 'chmod +x ./gradlew'
        sh './gradlew build -x test'
     }

     stage('docker build') {
         app = docker.build("${ECR_HOST}/crm")
     }

     stage('docker push') {
         docker.withRegistry("https://${ECR_HOST}", "${ECR_SECRET}") {
             app.push("${env.BUILD_NUMBER}")
             app.push("latest")
     }
  }
}