all: stop start exec

start:
	docker run -it -d \
		--env TF_NAMESPACE=$$TF_NAMESPACE \
		--env AWS_PROFILE="kh-labs" \
		--env AWS_ACCESS_KEY_ID="$$(sed -n 2p creds/credentials | sed 's/.*=//')" \
		--env AWS_SECRET_ACCESS_KEY="$$(sed -n 3p creds/credentials | sed 's/.*=//')" \
		--env OWNER=$$OWNER \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $$(pwd):/work \
		-w /work \
		--name pawst_ps \
		bryandollery/terraform-packer-aws-alpine

stop:
	docker rm -f pawst_ps 2> /dev/null || true

exec:
	docker exec -it pawst_ps bash || true

build:
	packer build packer.json
