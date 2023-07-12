pipeline {
  agent any
  stages {
    stage("stage 1") {
      steps {
        sh '''
          sudo docker-compose down || true
        '''
      }
    }

    stage("run") {
      steps {
        sh """
          sudo docker-compose -f docker-compose.yaml up -d --build --force-recreate
          sudo service jenkins restart
          """
      }
    }
  }
}