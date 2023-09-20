# Use the base image with development tools
FROM ubuntu:latest

LABEL maintainer='K.B.Dharun Krishna'

# Set environment variables for non-interactive package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y ns2 && \
    apt-get install -y git

# Download and install NAM
RUN wget https://github.com/kbdharun/CN-Lab/releases/download/nam/nam_1.14_amd64.deb && \
    dpkg -i nam_1.14_amd64.deb && \
    apt-get install -f

# Download and install XGraph
RUN wget https://github.com/kbdharun/CN-Lab/releases/download/nam/xgraph_12.1-17_amd64.deb && \
    dpkg -i xgraph_12.1-17_amd64.deb && \
    apt-get install -f

# Cleanup downloaded DEB files
RUN rm -f nam_1.14_amd64.deb && \
    rm -f xgraph_12.1-17_amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create the vscode user
RUN useradd -ms /bin/bash vscode

# Set the working directory
WORKDIR /app

# Command to run when the container starts
CMD ["/bin/bash"]
