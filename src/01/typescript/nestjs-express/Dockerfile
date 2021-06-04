FROM node:16-alpine

EXPOSE 3000

COPY ./ /app

WORKDIR /app

# Install modules
RUN ["npm", "i"]
# Build application
RUN ["npm", "run", "build"]
# Prune non-production packages
RUN ["npm", "prune", "--production"]

# Run production application
CMD ["npm", "run", "start:prod"]
