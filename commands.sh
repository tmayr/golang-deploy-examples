# compile the binary using current arch
go build -o sample-binary sample.go

# compile the binary using cross arch
GOOS=linux go build -o sample-binary sample.go

# execute previous linux binary in a ephemeral alpine container
docker run -v $(PWD):/root  -it --rm alpine:latest /root/sample-binary


### we docker now

# build the Dockerfile using Dockerfile-single
docker build . -t golang-deploy-examples-single:latest -f Dockerfile-single

# build the Dockerfile using Dockerfile-stages
docker build . -t golang-deploy-examples-stages:latest -f Dockerfile-stages

# execute with autorestart flag to demo autorestart speed
docker run -dt --restart always -m 64M --name golang-deploy-examples-stages golang-deploy-examples-stages:latest

# log it
docker logs golang-deploy-examples-stages --follow

# check the container status
docker stats

### cleanup

# stop running containers
docker stop golang-deploy-examples-stages

# remove containers
docker rm golang-deploy-examples-stages

# remove images
docker rmi golang-deploy-examples-single:latest
docker rmi golang-deploy-examples-stages:latest