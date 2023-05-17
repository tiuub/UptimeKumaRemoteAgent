FROM curlimages/curl
ADD ./uptimekumaremoteclient.sh /uptimekumaremoteclient.sh
RUN chmod +x /uptimekumaremoteclient.sh
CMD ["/uptimekumaremoteclient.sh"]