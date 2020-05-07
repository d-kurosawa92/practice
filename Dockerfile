FROM centos:7

RUN echo "centos version"
RUN cat /etc/redhat-release

RUN echo "now building..."

RUN yum update -y

RUN yum -y install unzip

RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm

RUN yum -y install git2u yum-utils

RUN yum-config-manager --disable ius

RUN echo "git version"

RUN git --version

RUN yum install -y yum-utils device-mapper-persistent-data lvm2

RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

RUN yum install -y docker-ce docker-ce-cli containerd.io

RUN echo "docker version"
RUN docker --version

RUN yum -y install httpd

RUN sed -i '/Listen 80/a Listen 8080' /etc/httpd/conf/httpd.conf

RUN echo "httpd version"
RUN httpd -v

ADD ./index.html /var/www/html/

RUN curl -k "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

RUN unzip awscliv2.zip

RUN ./aws/install

RUN echo "aws version"

RUN aws --version

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
