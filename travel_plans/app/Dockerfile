FROM amberframework/amber:1.3.2

WORKDIR /app

COPY shard.* /app/
RUN shards install

COPY . /app

RUN rm -rf /app/node_modules

CMD crystal run src/app.cr
