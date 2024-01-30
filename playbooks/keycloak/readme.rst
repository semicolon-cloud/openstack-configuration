Install Keycloak
###############
:tags: openstack, ansible

About this repository
---------------------

This set of playbooks will deploy Keycloak. If this is being deployed as part of
an OpenStack all of the inventory needs will be provided for.

**These playbooks require Ansible 2.4+.**

Deployment Process
------------------

Create the containers

.. code-block:: bash

   cd /opt/openstack-ansible/playbooks
   openstack-ansible lxc-containers-create.yml -e 'container_group=keycloak'

install keycloak

.. code-block:: bash

    cd /opt/openstack-ansible-ops/keycloak
    openstack-ansible installKeycloak.yml
