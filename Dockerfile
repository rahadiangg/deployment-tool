FROM ubuntu:24.04

# Use the TARGETARCH build argument to determine the architecture
ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH}

RUN echo ${TARGETARCH} > target-arch.txt

RUN apt update && apt install -y \
    curl wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Install nomad
RUN wget -P /tmp https://releases.hashicorp.com/nomad/1.8.1/nomad_1.8.1_linux_${TARGETARCH}.zip && \
    unzip /tmp/nomad_1.8.1_linux_${TARGETARCH}.zip -d /tmp/nomad_1.8.1_linux_${TARGETARCH} && \
    mv /tmp/nomad_1.8.1_linux_${TARGETARCH}/nomad /usr/local/bin && \
    rm /tmp/nomad_1.8.1_linux_${TARGETARCH}.zip && \
    rm -rf /tmp/nomad_1.8.1_linux_${TARGETARCH}

# Install terraform
RUN wget -P /tmp https://releases.hashicorp.com/terraform/1.9.1/terraform_1.9.1_linux_${TARGETARCH}.zip && \
    unzip /tmp/terraform_1.9.1_linux_${TARGETARCH}.zip -d /tmp/terraform_1.9.1_linux_${TARGETARCH} && \
    mv /tmp/terraform_1.9.1_linux_${TARGETARCH}/terraform /usr/local/bin && \
    rm /tmp/terraform_1.9.1_linux_${TARGETARCH}.zip && \ 
    rm -rf /tmp/terraform_1.9.1_linux_${TARGETARCH}

# Install OpenTofu
RUN wget -P /tmp https://github.com/opentofu/opentofu/releases/download/v1.7.2/tofu_1.7.2_linux_${TARGETARCH}.zip && \
    unzip /tmp/tofu_1.7.2_linux_${TARGETARCH}.zip -d /tmp/tofu_1.7.2_linux_${TARGETARCH} && \
    mv /tmp/tofu_1.7.2_linux_${TARGETARCH}/tofu /usr/local/bin && \
    rm /tmp/tofu_1.7.2_linux_${TARGETARCH}.zip && \
    rm -rf /tmp/tofu_1.7.2_linux_${TARGETARCH}