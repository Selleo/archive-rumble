import type { Server } from 'http';
import { NestFactory } from '@nestjs/core';
import { cpus } from 'os';
import { fork, isWorker } from 'cluster';
import { AppModule } from './app.module';
import { createLogger } from './utils/createLogger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    logger: createLogger(),
  });

  const server: Server = await app.listen(3000);
  server.setTimeout(30_000);
}

if (isWorker) {
  bootstrap();
} else {
  for (const _ of cpus()) {
    fork();
  }
}
