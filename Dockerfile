FROM ubuntu:latest

ADD pull-scan.sh /app/pull-scan.sh

WORKDIR /app

RUN apt update -y && apt install bash curl sudo jq  -y

RUN curl -s -L https://gist.githubusercontent.com/raphabot/bcdf92008756a4bc8e004b304a489692/raw/cbf29b11a4428a6d4314c39e5085719ab6d0a1b1/c1cs-install.sh | bash

RUN OS=Linux && ARCH=x86_64 && VERSION=$(curl -s "https://api.github.com/repos/google/go-containerregistry/releases/latest" | jq -r '.tag_name') && curl -sL "https://github.com/google/go-containerregistry/releases/download/${VERSION}/go-containerregistry_${OS}_${ARCH}.tar.gz" > go-containerregistry.tar.gz && tar -zxvf go-containerregistry.tar.gz -C /usr/bin/ crane

ENTRYPOINT [ "bash", "pull-scan.sh" ]
