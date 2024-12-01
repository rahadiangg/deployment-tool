FROM ubuntu:24.04

# Use the TARGETARCH build argument to determine the architecture
ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH}

RUN echo ${TARGETARCH} > target-arch.txt

RUN apt update && apt install -y \
    curl wget unzip apt-transport-https ca-certificates curl gnupg && \
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

# Install kubectl
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list && \
    chmod 644 /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

# Instal helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    rm ./get_helm.sh

# Install gcloud
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get update && apt-get install google-cloud-cli -y &&