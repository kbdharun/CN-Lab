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
RUN retries=3 && \
    until wget https://xgraph.org/linux/xgraph_4.38_linux64.tar.gz || [ $retries -eq 0 ]; do \
        echo "Retrying..."; \
        retries=$((retries-1)); \
        sleep 5; \
    done && \
    tar xvfz xgraph_4.38_linux64.tar.gz -C /usr/local/bin/ && \
    rm -f xgraph_4.38_linux64.tar.gz

# Cleanup
RUN rm -rf nam_1.14_amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Run xgraph directly
CMD ["xgraph"]
