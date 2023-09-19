FROM ubuntu:latest
LABEL maintainer='K.B.Dharun Krishna'
RUN apt install ns -y
RUN wget https://github.com/kbdharun/CN-Lab/releases/download/nam/nam_1.14_amd64.deb
RUN apt install ./nam_1.14_amd64.deb
RUN wget https://xgraph.org/linux/xgraph_4.38_linux64.tar.gz 
RUN tar xvfz xgraph_4.38.tar.gz
