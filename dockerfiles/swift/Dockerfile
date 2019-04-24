FROM ibmcom/swift-ubuntu:5.0

RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install libz-dev libpq-dev openssl libssl-dev curl -y
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
RUN curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update -y && apt-get upgrade -y

WORKDIR /hermes
COPY / .
#RUN chown -R $(whoami) .
#RUN chmod 777 ./wait-for-pg.sh
#RUN swift build -c release -Xcc -I/usr/include/postgresql
RUN swift build -Xcc -I/usr/include/postgresql

EXPOSE 80

#CMD ./.build/x86_64-unknown-linux/release/Hermes
CMD ./.build/x86_64-unknown-linux/debug/Hermes
