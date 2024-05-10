      # Base Image must be jdk 11 as Pentaho 9.3 needs this version
      # runtime necessary due to jar command to unzip file (unzip would be ok as well but is not installed)
      FROM registry.access.redhat.com/ubi9/openjdk-11:latest

      LABEL org.opencontainers.image.title="Pentaho"
      LABEL org.opencontainers.image.url="https://git.muenchen.de/isi/isi-pentaho-image"
      LABEL org.opencontainers.image.authors="tiago.kocevar albrecht.schaenzel"
      LABEL org.opencontainers.image.description="Image fuer Pentaho"

      # Set required environment vars
      ENV PDI_RELEASE=9.3
      ENV PDI_VERSION=9.3.0.0-428
      ENV CARTE_PORT=8080
      ENV PENTAHO_JAVA_HOME=$JAVA_HOME
      ENV PENTAHO_HOME=$HOME/pentaho
      ENV PENTAHO_URL=https://privatefilesbucket-community-edition.s3.us-west-2.amazonaws.com/${PDI_VERSION}/ce/client-tools/pdi-ce-${PDI_VERSION}.zip

      # Pentaho Directory
      RUN mkdir ${PENTAHO_HOME}
      RUN chmod 775 ${PENTAHO_HOME}

      # Download PDI and extract it
      RUN curl ${PENTAHO_URL} -o $HOME/pdi-ce-${PDI_VERSION}.zip
      RUN cd $PENTAHO_HOME && jar -xvf $HOME/pdi-ce-${PDI_VERSION}.zip
      RUN rm $HOME/pdi-ce-${PDI_VERSION}.zip

      # We can only add KETTLE_HOME to the PATH variable now
      # as the path gets evaluated - so it must already exist
      ENV KETTLE_HOME=${PENTAHO_HOME}/data-integration
      ENV PATH=${KETTLE_HOME}:$PATH
      RUN chmod 775 ${KETTLE_HOME}
      RUN chmod 755 ${KETTLE_HOME}/*.sh

      # Start Carte Server
      RUN cd ${KETTLE_HOME}
      CMD ${KETTLE_HOME}/carte.sh ${HOSTNAME} ${CARTE_PORT} -u ${PENTAHO_USER} -p ${PENTAHO_PASSWORD}
