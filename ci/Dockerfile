
FROM ubuntu
MAINTAINER mkb

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install curl
RUN apt-get -y install git
RUN apt-get -y install build-essential libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev

WORKDIR /opt
RUN curl -L -O http://erlang.org/download/otp_src_17.0.tar.gz
RUN tar zxvf otp_src_17.0.tar.gz
WORKDIR /opt/otp_src_17.0
RUN ./configure && make && sudo make install

RUN mkdir -p /opt/elixir
WORKDIR /opt/elixir
RUN curl -L -o elixir.zip https://github.com/elixir-lang/elixir/releases/download/v0.14.1/Precompiled.zip
RUN unzip elixir.zip

RUN git clone https://github.com/sarnowski/generic-ci.git /opt/generic-ci
ADD ./genci.config  /etc/genci/pifight

RUN ssh-keygen -t rsa -b 4096 -N '' -C genci -f /root/.ssh/id_rsa

WORKDIR /opt
RUN mkdir -p /opt/elixir
WORKDIR /opt/elixir
RUN curl -L -o elixir.zip https://github.com/elixir-lang/elixir/releases/download/v0.14.1/Precompiled.zip
RUN unzip elixir.zip

# RUN curl -sSL https://get.rvm.io | bash -s stable
# RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc

# RUN /bin/bash -l -c "rvm requirements"
# RUN /bin/bash -l -c "rvm install 2.0"

# WORKDIR /tmp
# ADD ./Gemfile Gemfile
# ADD ./Gemfile.lock Gemfile.lock
# RUN /bin/bash -l -c "bundle install"

# EXPOSE 3030

ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["echo gug; ls -al"]
