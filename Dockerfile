FROM golang:alpine AS build
WORKDIR /go
# Install MailHog as statically compiled binary:
# ldflags explanation (see `go tool link`):
#   -s  disable symbol table
#   -w  disable DWARF generation
RUN apk --no-cache add --virtual build-dependencies git
RUN CGO_ENABLED=0 GOPATH=/go go get -u -ldflags='-s -w' github.com/mailhog/MailHog

FROM scratch
# ca-certificates are required for the "release message" feature:
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /go/bin/MailHog /bin/
# Avoid permission issues with host mounts by assigning a user/group with
# uid/gid 1000 (usually the ID of the first user account on GNU/Linux):
USER 1000:1000
ENTRYPOINT ["MailHog"]
# Expose the SMTP and HTTP ports used by default by MailHog:
EXPOSE 1025 8025
