nsible Role: httpd (Apache for RHEL)
Overview:
This role installs, configures, and manages the Apache HTTP Server (httpd) on RHEL based systems like RHEL, CentOS, Rocky Linux, AlmaLinux and Amazon Linux. The role follows 
the standard Ansible role directory structure.

Role Directory Structure:
httpd/
defaults/
main.yml
files/
handlers/
main.yml
meta/
main.yml
tasks/
main.yml
templates/
apache.conf.j2
vars/
main.yml
README.md
Explanation of Each Directory:


tasks/     -> Main actions of the role (install, configure, start service)
handlers/  -> Tasks triggered by notify (restart httpd)
templates/ -> Jinja2 template files (apache.conf.j2)
files/     -> Static files copied as-is
defaults/  -> Lowest priority variables (safe defaults)
vars/      -> Higher priority variables (must-use or OS-specific)
meta/      -> Role metadata (author, platform, dependencies)
tests/     -> Optional test playbooks

tasks/
This directory contains the main actions that the role performs.
File: tasks/main.yml
Actions include installing httpd package, creating web root, copying index.html, deploying Apache config using template, and enabling or starting the httpd service. Tasks run in order and form the core logic of the role.


handlers/
Handlers are special tasks that run only when triggered by a notify event.
File: handlers/main.yml
Example handler: restarting httpd service when configuration changes. Handlers prevent unnecessary service restarts.


templates/
This directory contains Jinja2 template files (.j2).
File example: apache.conf.j2
Templates allow dynamic configuration files using Ansible variables like httpd_user, httpd_port, httpd_web_root. Used for generating Apache configurations.


files/
Contains static files that are copied exactly as they are to the target server.
Examples: static HTML files, certificates, or any file that does not need templating. This role may or may not use it, but it is part of the standard role structure.


defaults/
Contains default variables for the role with the lowest priority.
File: defaults/main.yml
Examples: httpd_port, httpd_user, httpd_web_root. These values can be overridden from inventory, playbooks or extra vars. Use defaults for optional or safe default values.


vars/
Contains variables with higher priority than defaults.
File: vars/main.yml
Used for values that rarely change or are OS specific. For RHEL, this may include httpd_pkg_name=httpd and httpd_service_name=httpd.


meta/
Contains metadata about the role.
File: meta/main.yml
Includes role author, supported platforms, dependencies and minimum Ansible version. Useful when publishing the role to Ansible Galaxy.


How to Use This Role:
Example playbook:

name: Install and configure Apache HTTPD on RHEL
hosts: webservers
become: yes
roles:
httpd



Run:
ansible-playbook -i inventory.ini site.yml
What This Role Does on RHEL:
Installs Apache (httpd)
Ensures service is running and enabled
Creates document root (/var/www/html)
Deploys Apache configuration using template
Creates default index.html
Restarts Apache when configuration changes
Validation:
curl -I http://server-ip
systemctl status httpd
