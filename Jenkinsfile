pipeline {
    agent any

    stages {
        stage('Build C# Code') {
            agent { 
                docker { image 'microsoft/dotnet:3.1-sdk' }
            }
            steps {
                echo 'Building C# Code'
                dotnet build
            }
        }
        stage('Run C# Tests') {
            agent { 
                docker { image 'microsoft/dotnet:3.1-sdk' }
            }
            steps {
                echo 'Running C# Tests'
                dotnet test
            }
        }
        stage('Install Node Dependencies') {
            agent { 
                docker { image 'node:14-alpine' }
            }
            steps {
                echo 'Installing Node Dependencies'
                dir('./DotnetTemplate.Web') {
                    npm install
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
                    npm run build
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
                    npm run lint
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
                    npm t
                }
            }
        }
    }
}