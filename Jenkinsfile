#!groovy
String PROJECTNAME = "makkelijkemarkt-mercato"
String CONTAINERDIR = "."
String CONTAINERNAME = "salmagundi/${PROJECTNAME}"
String DOCKERFILE = "Dockerfile"
String INFRASTRUCTURE = "secure"
String PLAYBOOK = "deploy-makkelijkemarkt-mercato.yml"

def tryStep (String message, Closure block, Closure tearDown = null) {
    try {
        block();
    }
    catch (Throwable t) {
        slackSend message: "${env.JOB_NAME}: ${message} failure ${env.BUILD_URL}", channel: "#salmagundi_ci", color: "danger"
        throw t;
    }
    finally {
        if (tearDown) {
            tearDown();
        }
    }
}

def retagAndPush (String imageName, String newTag) {
    def regex = ~"^https?://"
    def dockerReg = "${DOCKER_REGISTRY_HOST}" - regex
    sh "docker tag ${dockerReg}/${imageName}:${env.BUILD_NUMBER} ${dockerReg}/${imageName}:${newTag}"
    sh "docker push ${dockerReg}/${imageName}:${newTag}"
}

pipeline {
    agent any

    options {
        timeout(time: 1, unit: "DAYS")
    }

    stages {
        stage("Checkout") {
            steps {
                checkout scm
            }
        }

        stage("Build") {
            steps {
                script {

                    tryStep "build", {
                        sh "git rev-parse HEAD > version_file"
                        sh "cat version_file"

                        docker.withRegistry("${DOCKER_REGISTRY_HOST}","docker_registry_auth") {
                            image = docker.build("${CONTAINERNAME}:${env.BUILD_NUMBER}","-f ${DOCKERFILE} ${CONTAINERDIR}")
                            image.push()
                        }
                    }

                }
            }
        }

        stage("Push and deploy") {
            stages {
                stage("Release") {
                    steps {
                        script {

                            tryStep "deployment", {
                                docker.withRegistry("${DOCKER_REGISTRY_HOST}","docker_registry_auth") {
                                    docker.image("${CONTAINERNAME}:${env.BUILD_NUMBER}").pull()
                                    retagAndPush("${CONTAINERNAME}", "${INVENTORY}")
                                }

                                build job: "Subtask_Openstack_Playbook", parameters: [
                                    [$class: "StringParameterValue", name: "INFRASTRUCTURE", value: "${INFRASTRUCTURE}"],
                                    [$class: "StringParameterValue", name: "INVENTORY", value: "${INVENTORY}"],
                                    [$class: "StringParameterValue", name: "PLAYBOOK", value: "${PLAYBOOK}"],
                                    ], wait: true
                            }

                            slackSend channel: "#salmagundi_ci", color: "warning", message: "${PROJECTNAME} ${INVENTORY} Release successful. URL: ${env.JOB_URL}"

                        }
                    }
                }
            }
        }
    }
}
