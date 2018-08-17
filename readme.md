# compile the binary using current arch
go build -o sample-binary sample.go

# execute it in your arch watch it work
./sample-binary

# compile the binary using cross arch (from osx to linux)
GOOS=linux go build -o sample-binary sample.go

# execute it in your arch and watch it fail
./sample-binary

# execute previous linux binary in an ephemeral alpine container and watch it work
docker run -v $(PWD):/root  -it --rm alpine:latest /root/sample-binary

### we docker now

# build the Dockerfile using Dockerfile-single, produces a golang:alpine image with all os deps
docker build . -t golang-deploy-examples-single:latest -f Dockerfile-single

# build the Dockerfile using Dockerfile-single, produces a golang:alpine image with all os deps, stripping debug and using upx
docker build . -t golang-deploy-examples-single-optimized:latest -f Dockerfile-single-optimized

# build the Dockerfile using Dockerfile-stages, produces an alpine and copies binary from previous docker step
docker build . -t golang-deploy-examples-stages:latest -f Dockerfile-stages

# build the Dockerfile using Dockerfile-stages-optimized, produces an alpine and copies binary from previous docker step, stripping debug and using upx
docker build . -t golang-deploy-examples-stages-optimized:latest -f Dockerfile-stages-optimized

# execute with autorestart flag
docker run -dt --restart always -m 64M --name golang-deploy-examples-stages golang-deploy-examples-stages-optimized:latest

# log it
docker logs golang-deploy-examples-stages --follow

# check the container status
docker stats

### cleanup

# stop running containers
docker stop golang-deploy-examples-stages-optimized

# remove containers
docker rm golang-deploy-examples-stages-optimized

# remove images
docker rmi golang-deploy-examples-single:latest
docker rmi golang-deploy-examples-stages:latest
docker rmi golang-deploy-examples-stages-optimized:latest