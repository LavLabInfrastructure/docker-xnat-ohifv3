# Use the Australian Imaging Service XNAT base image
FROM ghcr.io/australian-imaging-service/xnat:latest
ARG XNAT_HOME=/data/xnat/home

# Install OHIF v3 Plugin
# Download and install the latest release from OHIF Plugin repository
ARG OHIF_PLUGIN_VERSION=latest
ARG OHIF_PLUGIN_DOWNLOAD_URL=""
RUN apt-get update && apt-get install -y wget unzip curl jq && \
    rm -rf /var/lib/apt/lists/*

# Create plugins directory if it doesn't exist
RUN mkdir -p $XNAT_HOME/plugins

# Download and install OHIF v3 Plugin
# Note: This supports both public and private repositories
WORKDIR /tmp


# Copy any JAR from the repository and rename the highest version to ohif-viewer-1.0.0.jar
COPY ohif-plugin/*.jar /tmp/
RUN set -e; \
    JAR_FILE=$(ls /tmp/*.jar | tail -n1); \
    rm -f /data/xnat/home/plugins/ohif-viewer-*.jar; \
    cp "$JAR_FILE" /data/xnat/home/plugins/ohif-viewer-1.0.0.jar;

RUN ls -la /data/xnat/home/plugins/
