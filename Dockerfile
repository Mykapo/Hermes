FROM swift:5.0

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
RUN curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install libz-dev libpq-dev -y

WORKDIR /hermes
ADD / .
RUN swift build -c release -Xcc -I/usr/include/postgresql

EXPOSE 80

CMD ./.build/x86_64-unknown-linux/release/Hermes
