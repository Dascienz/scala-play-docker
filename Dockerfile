FROM openjdk:8

# Environment variables
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV SBT_VERSION 1.3.8
ENV APP_PORT 9000
ENV PROJECT_HOME /src/main/java

# Install curl
RUN apt-get update && \
    apt-get install sudo && \
    sudo apt-get -y install curl && \
    sudo apt-get -y install vim

# Install sbt
RUN sudo curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
    sudo dpkg -i sbt-$SBT_VERSION.deb && \
    sudo rm sbt-$SBT_VERSION.deb && \
    sudo apt-get update && \
    sudo apt-get -y install sbt

# Copy project over
COPY . $PROJECT_HOME

# Set working directory
WORKDIR $PROJECT_HOME

RUN sbt update

# expose service port
EXPOSE $APP_PORT

# docker container entrypoint
ENTRYPOINT ["sbt", "run"]
