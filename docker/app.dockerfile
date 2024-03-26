FROM debian:latest

RUN apt update && apt install -y apache2 php php-mysqli php-gd php-curl php-xml php-mbstring curl unzip

RUN apt clean

RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

RUN rm /var/www/html/index.html

RUN curl -o drupal.tar.gz -fSL "https://www.drupal.org/download-latest/tar.gz" \
    && tar -xz --strip-components=1 -f drupal.tar.gz \
    && rm drupal.tar.gz

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

RUN a2enmod rewrite

WORKDIR /var/www/html/

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
