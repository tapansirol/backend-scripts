/*
 ******************************************************************************
 name : "Configure Maven Auto Installer",
 comment : "Configure maven auto-installer in Jenkins global configuration",
 Version : 3.6.1
 Author : Tapan Sirole
*********************************************************************************
*/

import hudson.plugins.gradle.GradleInstallation;
import hudson.tools.InstallSourceProperty;
import hudson.tools.ToolProperty;
import hudson.tools.ToolPropertyDescriptor;
import hudson.util.DescribableList;

String version = "5.0"
String name = "Gradle_Local"
//def gradleDesc = jenkins.model.Jenkins.instance.getExtensionList(hudson.tasks.Gradle.DescriptorImpl.class)[0]
def gradleDesc = jenkins.model.Jenkins.instance.getDescriptorByType(hudson.plugins.gradle.GradleInstallation.DescriptorImpl)
def srcProperties = new InstallSourceProperty()
def autoInstaller = new hudson.plugins.gradle.GradleInstaller(version)
srcProperties.installers.add(autoInstaller)

def properties = new DescribableList<ToolProperty<?>, ToolPropertyDescriptor>()
properties.add(srcProperties)
def installation = new GradleInstallation(name, "", properties)
gradleDesc.setInstallations(installation)
gradleDesc.save()





