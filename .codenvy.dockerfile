FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=symfony \
    BITNAMI_APP_VERSION=3.1.3 \
    PATH=/opt/bitnami/symfony:/opt/bitnami/php/bin:/opt/bitnami/mysql/bin/:$PATH

# Install java dependency
RUN bitnami-pkg install java-1.8.0_91-0 --checksum 64cf20b77dc7cce3a28e9fe1daa149785c9c8c13ad1249071bc778fa40ae8773

# Install Symfony related dependencies
RUN bitnami-pkg install php-7.0.10-0 --checksum 5f2ec47fcfb2fec5197af6760c5053dd5dee8084d70a488fd5ea77bd4245c6b9
RUN bitnami-pkg install mysql-client-10.1.13-4 --checksum 14b45c91dd78b37f0f2366712cbe9bfdf2cb674769435611955191a65dbf4976
RUN bitnami-pkg install mariadb-10.1.14-4 --checksum 4a75f4f52587853d69860662626c64a4540126962cd9ee9722af58a3e7cfa01b

# Install symfony module
RUN bitnami-pkg install symfony-2.8.9-0 --checksum 10de26781562de9ac73c010fce5f36d9e84b2c793d880b5f8df4831ae722ecf7 -- --applicationDirectory /projects

EXPOSE 8000

USER bitnami

WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:8000:ref=symfony che:server:8000:protocol=http

ENV TERM=xterm

CMD ["tail", "-f", "/dev/null"]