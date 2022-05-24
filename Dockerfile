# use multi-stage build inorder to have smaller image size
FROM golang:1.18.2-alpine3.15 AS base    

RUN mkdir /app   
# copy all files from current directory to /app
COPY .   /app         

# set working directory to /app
WORKDIR /app      

RUN go mod init     
# build the app
RUN go build -o main .  

# use multi-stage build inorder to have smaller image size
FROM alpine       

WORKDIR /app  
# Copy the app binary from base image (previous stage)
COPY --from=base /app/ /app/
# expose port 8080
EXPOSE 8080 

CMD ["./main"]