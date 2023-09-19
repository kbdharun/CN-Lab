FROM ubuntu:latest
LABEL maintainer='K.B.Dharun Krishna'

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y ns2

# Download and install NAM
RUN wget https://github.com/kbdharun/CN-Lab/releases/download/nam/nam_1.14_amd64.deb && \
    dpkg -i nam_1.14_amd64.deb && \
    apt-get install -f

# Download and extract XGraph
RUN wget https://xgraph.org/linux/xgraph_4.38_linux64.tar.gz && \
    tar xvfz xgraph_4.38_linux64.tar.gz && \
    mv xgraph_4.38 /usr/local/bin/xgraph

# Cleanup
RUN rm -rf nam_1.14_amd64.deb xgraph_4.38_linux64.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
