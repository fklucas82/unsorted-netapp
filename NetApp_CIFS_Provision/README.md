CIFS_Provision
Provision a new CIFS SVM (storage virtual machine) and Shares on the Production NetApp

To run this you'll need the netapp specific storage modules installed:

sudo pip install netapp-lib solidfire-sdk-python

Recommended reading for NetApp Ansible Automation:

https://netapp.io/2018/10/08/getting-started-with-netapp-and-ansible-install-ansible/

Creates a new SVM

Configures networking on new SVM

Creates DNS record for new SVM

Creates CIFS Server on SVM

Creates Volume(s)

Creates Shares(s)

Creates OU for Server in Hy-Vee\Corporate\Security Groups\File Shares

Creates Groups for Full Control, Read Only, Modify, Read and Execute permissions for each share

Sets NTFS permissions for each share for the created groups

Creates an SVM at DR

Establishes Replication to DR SVM

Things to do:

Inheritance enable/disable

Create a readme for each role

Expand the use of tags for each role
