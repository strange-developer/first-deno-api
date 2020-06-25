FROM frolvlad/alpine-glibc:alpine-3.11_glibc-2.31

ENV DENO_VERSION=1.1.0

RUN apk add --virtual .download --no-cache curl \
 && curl -fsSL https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip \
         --output deno.zip \
 && unzip deno.zip \
 && rm deno.zip \
 && chmod 777 deno \
 && mv deno /bin/deno \
 && apk del .download

RUN addgroup -g 1993 -S deno \
 && adduser -u 1993 -S deno -G deno \
 && mkdir /deno-dir/ \
 && chown deno:deno /deno-dir/

RUN deno install --allow-read --allow-run --allow-write --allow-net -f --unstable https://deno.land/x/denon/denon.ts

ENV DENO_DIR /deno-dir/

EXPOSE 8000

WORKDIR /home/node/app

# Prefer not to run as root.
USER deno

# These steps will be re-run upon each file change in your working directory:
COPY . .

# Compile the main app so that it doesn't need to be compiled each startup/entry.
RUN deno cache app.ts