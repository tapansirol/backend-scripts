import jenkins.model.*
import groovy.json.JsonSlurper
import hudson.plugins.sonar.SonarInstallation
import hudson.plugins.sonar.SonarRunnerInstallation
import hudson.plugins.sonar.SonarRunnerInstaller
import hudson.plugins.sonar.model.TriggersConfig
import hudson.tools.InstallSourceProperty


Properties props = new Properties()
File propsFile = new File('/var/jenkins_home/init.groovy.d/pipeline.properties')
props.load(propsFile.newDataInputStream())

def sonarHostIp = props.getProperty('SONARQUBE_SERVICE_NAME')

def sonarHost = "http://" + sonarHostIp + ":" + "9000"
//def ip = env['HOST_IP']
//def port = env['SONAR_PORT']
//def sonarHost = "http://" + ip + ":" + port
def token = props.getProperty('SONAR_TOKEN');

def sonarConfig = Jenkins.instance.getDescriptor('hudson.plugins.sonar.SonarGlobalConfiguration')

SonarInstallation sonarInst = new SonarInstallation(
        "sonar-server", sonarHost, token, "", "", new TriggersConfig(), "")
sonarConfig.setInstallations(sonarInst)
sonarConfig.setBuildWrapperEnabled(true)
sonarConfig.save()
