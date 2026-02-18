FROM alpine:3.20

# Install Apache2 and OpenSSH
RUN apk update && \
    apk add --no-cache apache2 openssh && \
    mkdir -p /run/apache2 /var/www/localhost/htdocs

# Configure Apache
RUN sed -i 's/^#ServerName.*/ServerName localhost/' /etc/apache2/httpd.conf

# Configure SSH
RUN ssh-keygen -A && \
    echo "root:labpassword" | chpasswd && \
    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Simple web page
RUN echo "<h1>Host-B-1 Web Server</h1><p>Apache on Alpine</p>" \
    > /var/www/localhost/htdocs/index.html

# Expose HTTP and SSH
EXPOSE 80 22

# Start both services
CMD ["/bin/sh", "-c", "httpd && /usr/sbin/sshd -D"]