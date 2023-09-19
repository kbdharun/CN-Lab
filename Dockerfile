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

# Retry downloading XGraph with retries
RUN wget https://github.com/kbdharun/CN-Lab/releases/download/nam/xgraph_12.1-17_amd64.deb && \
    dpkg -i xgraph_12.1-17_amd64.deb && \
    apt-get install -f

# Cleanup
RUN rm -rf nam_1.14_amd64.deb && \
    rm -rf xgraph_12.1-17_amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Run xgraph directly
CMD ["xgraph"]
