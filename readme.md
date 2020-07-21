# A packer configuration to create a K3S server on an ubuntu base and expose its key file on port 8765 via an nginx docker container

This is designed to be used in a security group that only allows access to port 8765 from another security group containing only authorised worker nodes (agents in K3S speak).

To use this file, please set the environtment variables OWNER, AWS_ACCESS_KEY_ID, and AWS_SECRET_ACCESS_KEY
