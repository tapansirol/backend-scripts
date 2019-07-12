# HCL UrbanCode Velocity

Use UrbanCode Velocity to standardize and automate processes in your release lifecycle and gather insights into your UrbanCode Deploy environment.
It allows you to move releases through your development cycle's phases, from preproduction to production. You create and implement a predictable schedule of releases for your software applications. If you use team-based planning software, you can integrate related changes to your release plan to make your plan comprehensive and clear. Your release plan and status can be shared with all stakeholders so that they know the schedule and the key milestones and can identify issues that might delay releases.

UrbanCode Velocity is an enterprise-scale release management service that supports both cloud-native and on-premises deployment tools. You can integrate your release with Jira, ServiceNow, and deployment risk analysis tasks.

## Installation Prerequisites

Before installing the Helm chart, ensure that you have completed the following steps:

- A valid access key and set it as:

  ```bash
  $ helm install <hcl-chart-repo>/velocity --set access.key=<access-key>
  ```
  
  You can use a [60-days trial](https://uc-velocity.com/) access key.
  
## Note

- Your cluster should have at least 4 nodes and ideally an autoscaler enabled.

- This version requires an HTTPS connection, to access the GUI. Hence, it should be hosted behind a secure load-balancer/reverse-proxy.