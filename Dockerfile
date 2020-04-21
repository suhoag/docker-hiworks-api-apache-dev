FROM ubuntu

# 업데이트 및 모듈 설치
RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get  install apt-utils software-properties-common tzdata apache2 vim -y && \
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

#apache 모듈 활성화
RUN a2enmod proxy_fcgi setenvif rewrite ssl

#볼륨 경로 생성(인증서)
RUN mkdir /etc/apache2/certificate

# 정리
RUN apt-get autoremove -y && apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -fr /etc/apache2/sites-enabled/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/var/www", "/etc/apache2/sites-enabled", "/etc/apache2/certificate"]
EXPOSE 80 443