# Docker container to present slides

FROM ubuntu:trusty

MAINTAINER Till Salzer <till.salzer@isax.com>

# base system
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git-core build-essential golang nginx

# the nginx configuration
ADD docker/default.conf /etc/nginx/available-sites/default

# the user
ENV USER user
ENV UID 1000
ENV USER_HOME /home/${USER}
ENV GOPATH ${USER_HOME}/presentation

RUN adduser --uid ${UID} -c "Slides Presentation User" ${USER}


# now, install all the required stuff into /home/user
WORKDIR ${USER_HOME}/presentation
ADD . ${USER_HOME}/presentation
RUN chown -R ${USER}:${USER} ${USER_HOME}/presentation

# compile and install as user ${USER}
USER ${UID}
RUN make bin/present bin/run_present

# install the run_present script as root
USER 0
RUN mv bin/run_present /usr/local/bin/run_present

# all the rest as ${USER}
USER ${UID}

# the default port is 3999
# EXPOSE 3999
EXPOSE 80

# ADD run_present.sh /home/user/bin/run_present.sh

# CMD ["/bin/bash", "-c", "/home/user/bin/present", "-http=\$(head -1 /etc/hosts | cut -f 1):3999", "-play=false"]

CMD ["/bin/bash", "-c", "/home/user/bin/run_present.sh"]
