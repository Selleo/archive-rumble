FROM hayd/alpine-deno:1.9.2

EXPOSE 3000

WORKDIR /app

USER deno

# These steps will be re-run upon each file change in your working directory:
ADD . .
# Compile the main app so that it doesn't need to be compiled each startup/entry.
RUN deno cache server.ts

CMD ["run", "--allow-net", "server.ts"]