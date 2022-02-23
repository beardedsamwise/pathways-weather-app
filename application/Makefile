DOCKERFILE = weather-app-dockerfile
export ACCOUNTID
export AWSREGION 
export REPONAME 

.PHONY: build
build:
	docker build -t $(ACCOUNTID).dkr.ecr.$(AWSREGION).amazonaws.com/$(REPONAME):1 -f $(DOCKERFILE) .

.PHONY: login
login:
	aws ecr get-login-password --region $(AWSREGION) | docker login --username AWS --password-stdin $(ACCOUNTID).dkr.ecr.$(AWSREGION).amazonaws.com

.PHONY: push
push:
	docker push $(ACCOUNTID).dkr.ecr.$(AWSREGION).amazonaws.com/$(REPONAME):1 