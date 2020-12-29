# RuneLite docker image
#
# author: obonobo ethanbnb@gmail.com
#
# All rights reserved...
#

FROM ubuntu
WORKDIR /root/

# Install Java
RUN apt update && apt install -y openjdk-14-jre

# Scripts and environment
COPY runelite-supervisor.sh /root/
COPY RuneLite.jar /root/
ENV GDK_SCALE=2

# Run the supervisor script as the default command
CMD ["/bin/bash", "runelite-supervisor.sh"]
