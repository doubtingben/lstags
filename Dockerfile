#
# NB! This file is a template and might need editing before it works on your project!
#
FROM golang:1.8 AS builder
WORKDIR /go/src/github.com/ivanilves/lstags
COPY . ./
RUN ln -nfs /bin/bash /bin/sh && make assemble
FROM scratch
# Since we started from scratch, we'll copy following files from the builder:
# * SSL root certificates bundle
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
# * compiled lstags binary
COPY --from=builder /go/src/github.com/ivanilves/lstags/lstags /lstags
ENTRYPOINT [ "/lstags" ]
CMD ["--help"]
