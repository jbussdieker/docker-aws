FROM ubuntu

RUN apt-get -y update && \
  apt-get -y install python3-pip

ARG aws_version

RUN : "${aws_version:?Must specify version}"

RUN pip3 install awscli==${aws_version}
