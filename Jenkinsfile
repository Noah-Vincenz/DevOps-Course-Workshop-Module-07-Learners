pipeline {
    agent { 
        docker { 
            image 'node:14-alpine',
            image 'microsoft/dotnet:3.1-sdk'
        }
    }

    stages {
        stage('Build C# Code') {
            steps {
                echo 'Building C# Code'
                dotnet build
            }
        }
        stage('Run C# Tests') {
            steps {
                echo 'Running C# Tests'
                dotnet test
            }
        }
        stage('Install Node Dependencies') {
            steps {
                echo 'Installing Node Dependencies'
                dir('./DotnetTemplate.Web') {
                    npm install
                }
            }
        }
        stage('Build Typescript Code') {
            steps {
                echo 'Building Typescript Code'
                dir('./DotnetTemplate.Web') {
                    npm run build
                }
            }
        }
        stage('Run Linter for the Typescript Code') {
            steps {
                echo 'Running the Linter for the Typescript Code'
                dir('./DotnetTemplate.Web') {
                    npm run lint
                }
            }
        }
        stage('Run Typescript Tests') {
            steps {
                echo 'Running Typescript Tests'
                dir('./DotnetTemplate.Web') {
                    npm t
                }
            }
        }
    }
}