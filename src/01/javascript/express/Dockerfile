FROM node:14.15.4-slim

EXPOSE 3000

WORKDIR /app

ADD . .

# Install modules
RUN ["npm", "i"]

CMD ["node", "index.js"]

