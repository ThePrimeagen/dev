FROM ubuntu:latest
WORKDIR /app
RUN apt update
RUN apt install -y software-properties-common 
RUN add-apt-repository --yes --update ppa:ansible/ansible 
RUN apt install -y ansible 
COPY . /app
CMD ["echo", "hello world"]
