FROM universalrobots/ursim_e-series
SHELL ["/bin/bash", "-i", "-c"]
ENV URTOOL_ROOT=/opt/urtool-3.0 \
    URTOOL_TARGET=i686-unknown-linux-gnu- \
    PATH="${PATH}:/opt/urtool-3.0/bin"
ENV URSIM=/ursim 

ARG url=https://s3-eu-west-1.amazonaws.com/ur-support-site/115819/sdk-1.18.0.zip
ARG sdk_version=sdk-1.18.0

RUN set -ex; \
    apt-get -y update; \
    apt-get install -y build-essential maven unzip dialog ant sshpass curl git bash; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* 

RUN set -ex; \
    curl $url -o $sdk_version.zip; \
    unzip $sdk_version.zip -d /$sdk_version; \
    rm $sdk_version.zip; \
    cd /$sdk_version; \
    yes | ./install.sh; \
    chmod a+rwx /ursim

CMD ["/bin/bash", "-i"]
