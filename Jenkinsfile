pipeline {
    agent none

    stages {
        stage('Build C# Code') {
            steps {
                echo 'Building C# Code'
                sh './dotnet-install.sh -c Current'
                sh 'dotnet build'
            }
        }
        stage('Run C# Tests') {
            steps {
                echo 'Running C# Tests'
                sh './dotnet-install.sh -c Current'
                sh 'dotnet test'
            }
        }
        stage('Install Node Dependencies') {
            agent { 
                docker { image 'node:14-alpine' }
            }
            steps {
                echo 'Installing Node Dependencies'
                dir('./DotnetTemplate.Web') {
                    sh 'npm install'
                }
            }
        }
        stage('Build Typescript Code') {
            agent { 
                docker { image 'node:14-alpine' }
            }
            steps {
                echo 'Building Typescript Code'
                dir('./DotnetTemplate.Web') {
                    sh 'npm run build'
                }
            }
        }
        stage('Run Linter for the Typescript Code') {
            agent { 
                docker { image 'node:14-alpine' }
            }
            steps {
                echo 'Running the Linter for the Typescript Code'
                dir('./DotnetTemplate.Web') {
                    sh 'npm run lint'
                }
            }
        }
        stage('Run Typescript Tests') {
            agent { 
                docker { image 'node:14-alpine' }
            }
            steps {
                echo 'Running Typescript Tests'
                dir('./DotnetTemplate.Web') {
                    sh 'npm t'
                }
            }
        }
    }
}