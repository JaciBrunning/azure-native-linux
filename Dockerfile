FROM 3387050b7f1c
RUN apt-get -y update && apt-get install -y \
  build-essential \
  clang-6.0 \
  gcc-5 g++-5 \
  g++-5-multilib gcc-5-multilib g++-multilib gcc-multilib \
  gnuplot \
  sudo \
  curl \
  java-common

# Alternatives
RUN update-alternatives --remove-all gcc || true
RUN update-alternatives --remove-all g++ || true
RUN update-alternatives --remove-all clang || true
RUN update-alternatives --remove-all clang++ || true
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 10 || true
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 10 || true
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 10 || true
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 10 || true

# OpenJDK 11
WORKDIR /usr/lib/jvm
RUN curl -SL https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz | tar xzf -
COPY jdk-11.0.1.jinfo .jdk-11.0.1.jinfo
RUN bash -c "grep /usr/lib/jvm .jdk-11.0.1.jinfo | awk '{ print \"update-alternatives --install /usr/bin/\" \$2 \" \" \$2 \" \" \$3 \" 2\"; }' | bash " \
  && update-java-alternatives -s jdk-11.0.1

ENV JAVA_HOME /usr/lib/jvm/jdk-11.0.1