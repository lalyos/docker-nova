FROM ubuntu

RUN apt-get update -qq
RUN apt-get install -y \
  curl \
  html2text \
  nginx
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENV TITLE=Welcome
ENV BODY="Please use BODY/COLOR/TITLE env vars"
ENV COLOR=gray
CMD ["/start.sh"]
