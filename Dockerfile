FROM jenkins/jenkins:lts



USER root



RUN mkdir -p /home/jenkins/agent



RUN apt-get update && \

    apt-get install -y curl && \

    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \

    apt-get install -y nodejs && \

    apt-get clean && \

    rm -rf /var/lib/apt/lists/*



USER jenkins

