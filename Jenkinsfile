pipeline {
    agent none

    stages {
        stage('C#') {
            agent {
                docker { 
                    image 'mcr.microsoft.com/dotnet/sdk:5.0' 
                    args '-e DOTNET_CLI_HOME="/tmp/DOTNET_CLI_HOME"' 
                }
            }
            stages {
                stage('Build C# Code') {
                    steps {
                        echo 'Building C# Code'
                        sh 'dotnet build'
                    }
                }
                stage('Run C# Tests') {
                    steps {
                        echo 'Running C# Tests'
                        sh 'dotnet test'
                    }
                }
            }
        }
        stage('Typescript') {
            agent { 
                docker { image 'node:14-alpine' }
            }
            stages {
                stage('Install Node Dependencies') {
                    steps {
                        echo 'Installing Node Dependencies'
                        dir('./DotnetTemplate.Web') {
                            sh 'npm install'
                        }
                    }
                }
                stage('Build Typescript Code') {
                    steps {
                        echo 'Building Typescript Code'
                        dir('./DotnetTemplate.Web') {
                            sh 'npm run build'
                        }
                    }
                }
                stage('Run Linter for Typescript') {
                    steps {
                        echo 'Running the Linter for the Typescript Code'
                        dir('./DotnetTemplate.Web') {
                            sh 'npm run lint'
                        }
                    }
                }
                stage('Run Typescript Tests') {
                    steps {
                        echo 'Running Typescript Tests'
                        dir('./DotnetTemplate.Web') {
                            sh 'npm t'
                        }
                    }
                }
            }
        }
    }
}