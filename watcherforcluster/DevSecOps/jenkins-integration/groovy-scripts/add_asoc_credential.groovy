import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.CredentialsScope
import jenkins.model.Jenkins
import com.ibm.appscan.jenkins.plugin.auth.ASoCCredentials



Properties props = new Properties()
File propsFile = new File('/var/jenkins_home/init.groovy.d/pipeline.properties')
props.load(propsFile.newDataInputStream())

def id = props.getProperty('ASOC_ID')
def secret = props.getProperty('ASOC_SECRET')
def domain = Domain.global()
def store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()
def asocCredential = new ASoCCredentials("ASOC_Staging", "Credential for ASOC", id, secret)
store.addCredentials(domain, asocCredential)
