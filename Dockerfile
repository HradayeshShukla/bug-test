FROM registry.access.redhat.com/ubi8/ubi:8.5
USER root

# I've observed some delay in mounting secrets to builder pod, hence a 10 second delay here. 
RUN sleep 10 

# Reviewing if yum auto-creates the repo file & 
RUN yum repolist --verbose && cat /etc/redhat-release && cat /etc/yum.repos.d/redhat.repo && yum repolist --verbose


### Disable RHEL7 repositories 
RUN yum -y install --disablerepo='rhel-7*' vulkan-loader redhat-lsb libXScrnSaver \
&& curl -o google-chrome-stable_current_x86_64.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm \
&& yum -y localinstall google-chrome-stable_current_x86_64.rpm 

# Remove entitlements
rm -rf /etc/pki/entitlement

