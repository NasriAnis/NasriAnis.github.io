FROM alpine:3.20

# Install required services
RUN apk update && \
    apk add --no-cache curl openssh

# Start
CMD ["/bin/sh"]