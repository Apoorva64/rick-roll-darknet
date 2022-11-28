FROM ubuntu
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
RUN apt install tor -y
COPY ./torconfig/site1/ /var/lib/tor/site1/
RUN chown -R debian-tor: /var/lib/tor/site1
RUN chmod -R u+rwX,og-rwx /var/lib/tor/site1
COPY ./torconfig/torrc /etc/tor/torrc
RUN touch /var/log/tor/error.log
# start tor service
CMD service tor start && tail -F /var/log/tor/error.log