/*
 ******************************************************************************
 name : "Configure Maven Auto Installer",
 comment : "Configure maven auto-installer in Jenkins global configuration",
 Version : 3.6.1
 Author : Tapan Sirole
*********************************************************************************
*/


import hudson.tasks.Maven.MavenInstallation;
import hudson.tools.InstallSourceProperty;
import hudson.tools.ToolProperty;
import hudson.tools.ToolPropertyDescriptor;
import hudson.util.DescribableList;

String version = "3.6.1"
String name = "MVN_Local-auto"
def mvnDesc = jenkins.model.Jenkins.instance.getExtensionList(hudson.tasks.Maven.DescriptorImpl.class)[0]
def srcProperties = new InstallSourceProperty()
def autoInstaller = new hudson.tasks.Maven.MavenInstaller(version)
isp.installers.add(autoInstaller)

def properties = new DescribableList<ToolProperty<?>, ToolPropertyDescriptor>()
properties.add(srcProperties)
def installation = new MavenInstallation(name, "", properties)
mvnDesc.setInstallations(installation)
mvnDesc.save()





