# textkernel_excercise
Excercise for Textkernel


This project uses Ansible for automation and GCP as cloud provider. Needs requests and google-auth packages. 

<code>
pip install requests google-auth
</code>

You need to pre-define a project on GCP, and pre-load the ssh keys to be able to connect to the instances.

This ansible scripts need ansible 2.9+ with GCP modules installed.

<code>
	ansible-galaxy collection install google.cloud
</code>

You need to create a service account with compute engine access, and get the json auth file from GCP and keep it in the upper directory of the script

Need to configure gcp os login for ssh from outside.

https://cloud.google.com/compute/docs/instances/managing-instance-access#gcloud_1

I have run the scripts on a computer running Elementary OS.

# createinstance.yml

This playbook creates a VM on GCP with predefined service account and specs.

Variables should be changed for your GCP account specs.


      gcp_project: hopeful-sound-326712						- should be your project
      gcp_cred_kind: serviceaccount
      gcp_cred_file: ../hopeful-sound-326712-793154e35200.json	                - your auth json file to the service account
      zone: "europe-west3-c"						 	- zone of your choice
      region: "europe-west3" 							- region of your choice



# deploygitlabserver.yml

This playbook creates a VM on GCP with predefined service account and specs,then installs a Gitlab server on it, ensures if it runs by checking port 80. Gitlab server IP is recorded inside gitlab-server file on the same directory of the playbook.

Variables should be changed for your GCP account specs.


      gcp_project: hopeful-sound-326712				    ---gcp project name
      gcp_cred_kind: serviceaccount
      gcp_cred_file: ../hopeful-sound-326712-793154e35200.json      ---auth json file to the service acocunt
      zone: "europe-west3-c"					    ---zone of your choice
      region: "europe-west3"					    ---region of your choice
      ssh_key_location: /home/bach/.ssh/id_rsa			    ---ssh key location for ssh access to the server
      ssh_user: bahadir.tasdelen				    ---ssh user
      gitlab_default_pass: G1tl4B!!!				    ---gitlab server password to use at installation



# deploygitlabrunner.yaml


This playbook creates a VM on GCP with predefined service account and specs,then installs a Gitlab runner on it. Gitlab runner server IP address is recorded inside gitlab-runner file on the same directory of the playbook.

Variables should be changed for your GCP account specs.


      gcp_project: hopeful-sound-326712				    ---gcp project name
      gcp_cred_kind: serviceaccount
      gcp_cred_file: ../hopeful-sound-326712-793154e35200.json      ---auth json file to the service acocunt
      zone: "europe-west3-c"					    ---zone of your choice
      region: "europe-west3"					    ---region of your choice
      ssh_key_location: /home/bach/.ssh/id_rsa			    ---ssh key location for ssh access to the server
      ssh_user: bahadir.tasdelen				    ---ssh user

# registerrunner.yaml

This playbook registers the installed runner to the installed Gitlab server. Uses the info inside the gitlab-server and gitlab-runner files for connection information. There is a need to login to the Gitlab server beforehand, and get the registration token. Then variable inside this yaml file then should be changed accordingly. After that, whenever you use deploygitlabrunner.yaml playbook, gitlab-runner file changes and you can use this script directly to register the new runner with the gitlab server.

      ssh_key_location: /home/bach/.ssh/id_rsa	---ssh key location for ssh access to the server
      ssh_user: bahadir.tasdelen		---ssh user
      token: Vm-myUj74nVdvs_6ZEFS		---Gitlab Server registration token. Should be changed according to the Gitlab Server installation.
      server_file: ./gitlab-server
      runner_file: ./gitlab-runner
