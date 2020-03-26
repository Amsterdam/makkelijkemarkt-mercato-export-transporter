#!groovy

// This is an non-typical pipeline.
// A docker container is started that runs a tasks and then exits.
// The code is not first deployed to acceptance and then promoted to production,
// but can be deployed to either using the INVENTORY variable.
// Confirmation for deployment is disabled, as deploys are triggered
// nightly from two Jenkins jobs (acceptance and production).
//
// Required parameters:
//   INVENTORY: 'acceptance' or 'production'

// Project settings for deployment
String PROJECTNAME = "makkelijkemarkt-mercato"
String CONTAINERDIR = "."
String TRIGGER_BRANCH = "master"
String INFRASTRUCTURE = 'secure'
String PLAYBOOK = 'deploy-makkelijkemarkt-mercato.yml'

// All other data uses variables, no changes needed for static
String CONTAINERNAME = "fixxx/makkelijkemarkt-mercato:${env.BUILD_NUMBER}"
String DOCKERFILE="Dockerfile"
String BRANCH = "${env.BRANCH_NAME}"


def tryStep(String message, Closure block, Closure tearDown = null) {
    try {
        block();
    }
    catch (Throwable t) {
        slackSend message: "${env.JOB_NAME}: ${message} failure ${env.BUILD_URL}", channel: '#ci-channel-app', color: 'danger'
        throw t;
    }
    finally {
        if (tearDown) {
            tearDown();
        }
    }
}

// Only trigger pipeline on the configured branch
if (BRANCH == "${TRIGGER_BRANCH}") {
    node {
        stage("Checkout") {
            checkout scm
        }
        stage("Build image") {
            tryStep "build", {
                docker.withRegistry("${DOCKER_REGISTRY_HOST}",'docker_registry_auth') {
                    image = docker.build("${CONTAINERNAME}","-f ${DOCKERFILE} ${CONTAINERDIR}")
                    image.push()
                    image.push("${INVENTORY}")
                }
            }
        }
        stage("Deploy") {
            tryStep "deployment", {
                build job: 'Subtask_Openstack_Playbook',
                parameters: [
                    [$class: 'StringParameterValue', name: 'INFRASTRUCTURE', value: "${INFRASTRUCTURE}"],
                    [$class: 'StringParameterValue', name: 'INVENTORY', value: "${INVENTORY}"],
                    [$class: 'StringParameterValue', name: 'PLAYBOOK', value: "${PLAYBOOK}"],
                ]
            }
        }
    }
}
