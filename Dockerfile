FROM alpine:latest AS builder

RUN apk add --update alpine-sdk linux-headers git zlib-dev libressl-dev gperf cmake ninja

WORKDIR /work

COPY . .

RUN ls -alh && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. .. && cmake --build . --target install

FROM alpine:latest AS final

COPY --from=builder /work/bin/telegram-bot-api /bin/telegram-bot-api

ENTRYPOINT ["/bin/telegram-bot-api"]