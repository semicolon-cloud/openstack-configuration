Install Grafana
###############
:tags: openstack, ansible

About this repository
---------------------

This set of playbooks will deploy Grafana. If this is being deployed as part of
an OpenStack all of the inventory needs will be provided for.

**These playbooks require Ansible 2.4+.**

Deployment Process
------------------

Create the containers

.. code-block:: bash

   cd /opt/openstack-ansible/playbooks
   openstack-ansible lxc-containers-create.yml -e 'container_group=grafana'

install grafana

.. code-block:: bash

    cd /opt/openstack-ansible-ops/grafana
    openstack-ansible installGrafana.yml
