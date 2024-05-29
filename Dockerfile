      # Base Image must be jdk 11 as Pentaho 9.3 needs this version

      #######################################################################################################
      # Layer install_unpack: Here we use an image for packing to make the final image as small as possible #
      #######################################################################################################
      # runtime necessary due to jar command to unzip file (unzip would be ok as well but is not installed)
      FROM registry.access.redhat.com/ubi9/openjdk-11:latest as install_unpack

      # Arguments
      ARG PDI_RELEASE=9.3
      ARG PDI_VERSION=9.3.0.0-428
      ARG PENTAHO_INSTALL=$HOME/pentaho-install
      ARG PENTAHO_URL=https://privatefilesbucket-community-edition.s3.us-west-2.amazonaws.com/${PDI_VERSION}/ce/client-tools/pdi-ce-${PDI_VERSION}.zip

      # Pentaho Directory
      RUN mkdir ${PENTAHO_INSTALL}

      WORKDIR ${PENTAHO_INSTALL}

      # Download PDI and extract it
      RUN curl ${PENTAHO_URL} -o $HOME/pdi-ce-${PDI_VERSION}.zip
      RUN jar -xvf $HOME/pdi-ce-${PDI_VERSION}.zip

      ##################################################################################################
      # Second layer: Here is where we create the final image                                          #
      ##################################################################################################
      FROM registry.access.redhat.com/ubi9/openjdk-11-runtime:latest

      #Arguments
      ARG PENTAHO_INSTALL=$HOME/pentaho-install

      # Labels
      LABEL org.opencontainers.image.title="Pentaho PDI Carte Server"
      LABEL org.opencontainers.image.url="https://github.com/it-at-m/penthao-carte"
      LABEL org.opencontainers.image.authors="silke.schmid"
      LABEL org.opencontainers.image.description="Image fuer Pentaho PDI Carte Server"

      # Environment settings
      ENV PENTAHO_JAVA_HOME=$JAVA_HOME
      ENV CARTE_PORT=8080
      ENV KETTLE_HOME=${HOME}/data-integration
      ENV PATH=${KETTLE_HOME}:$PATH

      # Create PENTAHO_HOME directory and make it writable
      RUN mkdir ${KETTLE_HOME}
      RUN chmod 775 ${KETTLE_HOME}

      WORKDIR ${KETTLE_HOME}

      # Copy Pentaho PDI from layer install_unpack to this layer
      COPY --from=install_unpack --chmod=775 ${PENTAHO_INSTALL}/data-integration/ ${KETTLE_HOME}/

      # Make PDI runnable
      RUN chmod 755 ${KETTLE_HOME}/*.sh

      # Start Carte Server
      CMD ${KETTLE_HOME}/carte.sh ${HOSTNAME} ${CARTE_PORT}