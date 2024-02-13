import jenkins.model.*
import hudson.security.*

def env = System.getenv()

def instance = Jenkins.getInstance()

println "--> creating local user 'USERNAME'"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount('admin','changeme1$')
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()