import type { Server } from 'http';
import { cpus } from 'os';
import { fork, isWorker } from 'cluster';
import { NestFactory } from '@nestjs/core';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import { createLogger } from './utils/createLogger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter(),
    { logger: createLogger() },
  );

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
