import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.CredentialsScope
import jenkins.model.Jenkins

//def env = System.getenv()
//def credentialId = env['GIT_CREDENTIAL_ID']
//def git_username = env['GIT_USERNAME']
//def git_token = env['GIT_TOKEN']
//def domain = Domain.global()

Properties props = new Properties()
File propsFile = new File('/var/jenkins_home/init.groovy.d/pipeline.properties')
props.load(propsFile.newDataInputStream())

def credentialId = props.getProperty('GIT_CREDENTIAL_ID')

def git_username = props.getProperty('GIT_USER_NAME')

def git_token = props.getProperty('GIT_TOKEN')
def domain = Domain.global()

def store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()
def githubAccount = new UsernamePasswordCredentialsImpl(
        CredentialsScope.GLOBAL, credentialId, git_token,
        git_username,
        git_token
)
store.addCredentials(domain, githubAccount)

